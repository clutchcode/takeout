require 'find'
require 'mp3info'
require 'uri_cache'

class MusicBusiness < ApplicationBusiness

  def search(pattern)
    artists = MusicArtist.with_name_like(pattern)
    albums = MusicAlbum.with_title_like(pattern)
    genres = MusicGenre.with_name_like(pattern)
    songs = MusicSong.with_title_like(pattern)
    { :artists => artists, :albums => albums, :genres => genres, :songs => songs }
  end

  def destroy
    MusicArtist.transaction do
      MusicArtist.destroy_all
      MusicAlbum.destroy_all
      MusicSong.destroy_all
      MusicCategory.destroy_all
      MusicGenre.destroy_all
      MusicImage.destroy_all
    end
  end

  def scan(directory = nil)
    directory ||= Takeout::Application.config.music_dir

    fanart = FanartService.new
    lastfm = Lastfm2Service.new
    mbz = Musicbrainz2Service.new

    Find.find(directory) do |path|

      next unless path =~ /\.(m4a|mp3)$/

      song = MusicSong.find_or_create_by_file_uri(path)
      next if song and song.last_modified.to_i == File.mtime(path).to_i

      tags = {}

      if path =~ /\.m4a$/
        mp4info = MP4Info.open(path)
        tags[:title] = mp4info.NAM
        tags[:album] = mp4info.ALB
        tags[:artist] = mp4info.AART || mp4info.ART
        tags[:genre] = mp4info.GNRE
        tags[:tracknumber] = mp4info.TRKN[0]
        tags[:totaltracks] = mp4info.TRKN[1]
        tags[:discnumber] = mp4info.DISK[0]
        tags[:totaldiscs] = mp4info.DISK[1]
        tags[:date] = mp4info.DAY
        tags[:originaldate] = mp4info.DAY
        tags[:year] = mp4info.DAY
        ##tags[:albumsort] = mp4info.SOAL
        tags[:artistsort] = mp4info.SOAA || mp4info.SOAR || to_sort_title(tags[:artist])
        tags[:musicbrainz_album_id] = mp4info.MUSICBRAINZ_ALBUM_ID
        tags[:musicbrainz_artist_id] = mp4info.MUSICBRAINZ_ALBUM_ARTIST_ID
        tags[:musicbrainz_track_id] = mp4info.MUSICBRAINZ_TRACK_ID
        tags[:musicbrainz_album_release_country] = mp4info.MUSICBRAINZ_ALBUM_RELEASE_COUNTRY
        tags[:musicbrainz_album_type] = mp4info.MUSICBRAINZ_ALBUM_TYPE
        tags[:musicbrainz_album_status] = mp4info.MUSICBRAINZ_ALBUM_STATUS
        tags[:length] = mp4info.SECS
        tags[:bitrate] = mp4info.BITRATE
        tags[:samplerate] = (mp4info.FREQUENCY*1000).to_i
        tags[:hascover] = mp4info.COVR != nil
        #tags[:cover] = mp4info.COVR
      end

      if path =~ /\.mp3$/
        Mp3Info.open(path) do |mp3info|
          txxx = {}
          mp3info.tag2.TXXX.each do |tag|
            name, value = tag.split(/[^\w\s_-]+/, 2)
            txxx[name] = value
          end if mp3info.tag2.TXXX

          tags[:title] = mp3info.tag.title
          tags[:album] = mp3info.tag.album
          tags[:artist] = mp3info.tag2.TPE2 || mp3info.tag2.TPE1 || mp3info.tag.artist
          tags[:genre] = mp3info.tag.genre_s
          tags[:tracknumber] = mp3info.tag.tracknum
          trck = mp3info.tag2.TRCK
          if trck and trck =~ /(\d+)\/(\d+)/
            tags[:tracknumber] = $1.to_i
            tags[:totaltracks] = $2.to_i
          end
          tpos = mp3info.tag2.TPOS
          if tpos and tpos =~ /(\d+)\/(\d+)/
            tags[:discnumber] = $1.to_i
            tags[:totaldiscs] = $2.to_i
          else
            tags[:discnumber] = 1
            tags[:totaldiscs] = 1
          end
          if mp3info.tag2.TDAT
            tags[:date] = Date.civil(mp3info.tag2.TYER.to_i,
                                            mp3info.tag2.TDAT[2, 2].to_i,
                                            mp3info.tag2.TDAT[0, 2].to_i)
          else
            tags[:date] = Date.civil(mp3info.tag2.TYER.to_i)
          end
          tags[:originaldate] = Date.civil(mp3info.tag2.TORY.to_i) if mp3info.tag2.TORY
          tags[:year] = mp3info.tag.year
          ##tags[:albumsort] = mp4info.SOAL
          tags[:artistsort] = txxx['ALBUMARTISTSORT'] || to_sort_title(tags[:artist])
          tags[:musicbrainz_album_id] = txxx['MusicBrainz Album Id']
          tags[:musicbrainz_artist_id] = txxx['MusicBrainz Album Artist Id']
          if mp3info.tag2.UFID
            id = mp3info.tag2.UFID.split(/[^\w\s_\-\.:\+\?\/]+/, 2)
            tags[:musicbrainz_track_id] = id[1]
          end
          tags[:musicbrainz_album_release_country] = txxx['MusicBrainz Album Release Country']
          tags[:musicbrainz_album_type] = txxx['MusicBrainz Album Type']
          tags[:musicbrainz_album_status] = txxx['MusicBrainz Album Status']
          tags[:asin] = txxx['ASIN']
          #tags[:cover] = mp4info.COVR
          tags[:length] = mp3info.length.to_i
          tags[:bitrate] = mp3info.bitrate
          tags[:samplerate] = mp3info.samplerate
          ##song.vbr = mp3info.vbr
          ##song.channel_mode = mp3info.channel_mode
          ##song.has_cover = mp3info.tag2.APIC != nil
          tags[:hascover] = mp3info.tag2.APIC != nil
        end
      end

      puts "scanning #{path}"

      #p tags
      #next

      unless tags[:musicbrainz_artist_id]
        tags[:musicbrainz_artist_id] = mbz.artist_mbid(tags[:artist]) if tags[:artist]
      end

      MusicSong.transaction do
        #begin
        song = MusicSong.find_or_create_by_file_uri(path)
        song.last_modified = File.mtime(path)
        song.title = tags[:title]
        song.track_number = tags[:tracknumber]
        song.total_tracks = tags[:totaltracks]
        song.length = tags[:length]
        song.bitrate = tags[:bitrate]
        song.sample_rate = tags[:samplerate]
        song.disc_number = tags[:discnumber]
        song.total_discs = tags[:totaldiscs]
        song.year = tags[:year]
        song.has_cover = tags[:hascover]
        song.mbid = tags[:musicbrainz_track_id]
        song.save!

        song.music_genres.delete_all
        if tags[:genre]
          tags[:genre].split(%r{,\s*}).each do |genre|
            music_genre = MusicGenre.find_or_create_by_name(genre)
            music_genre.music_songs << song
          end
        end

        if tags[:musicbrainz_album_id]
          album = MusicAlbum.find_or_create_by_mbid(tags[:musicbrainz_album_id])
        elsif tags[:asin]
          album = MusicAlbum.find_or_create_by_asin(tags[:asin])
        else
          album = MusicAlbum.find_or_create_by_title(tags[:album])
        end
        album.title = tags[:album]
        album.sort_title = to_sort_title(album.title)
        album.year = tags[:year]
        album.asin = tags[:asin]
        album.mbid = tags[:musicbrainz_album_id]
        album.original_date = tags[:originaldate]
        album.release_country = tags[:musicbrainz_album_release_country]
        album.release_date = tags[:date]
        album.release_status = tags[:musicbrainz_album_status]
        album.release_type = tags[:musicbrainz_album_type]
        album.total_tracks = tags[:totaltracks]  # TODO bug with multi-disc albums
        album.total_length ||= 0
        album.total_length += tags[:length]
        album.music_songs << song
        album.save!

        artist_name = tags[:artist]
        sort_name = tags[:artistsort]

        artist = MusicArtist.find_or_create_by_name(artist_name)
        artist.mbid = tags[:musicbrainz_artist_id]
        artist.sort_name = sort_name.downcase
        artist.save!
        artist.music_albums << album

        fanart_images = artist.music_images.where(:source => 'fanart')

        if fanart_images.empty?
          images = fanart.artist_all(artist.mbid) if artist.mbid
          images.each_value do |v|
            v.each do |key, value|
              #artist.music_images.where(:source => 'fanart').destroy_all
              if key =~ /(albumcover|artistbackground|artistthumb|cdart|musiclogo)/
                value.each do |image|
                  artist.music_images.create!(
                      :source => 'fanart',
                      :image_type => key,
                      :url => image['url'],
                      :sort_order => image['likes'])
                end
              end
            end
          end if images
        end

        lastfm_images = artist.music_images.where(:source => 'lastfm')
        if lastfm_images.empty?
          artist_info = artist.mbid ? lastfm.artist_info(:mbid => artist.mbid) :
              lastfm.artist_info(:artist => artist.name)
          images = artist_info['artist'] ? artist_info['artist']['image'] : nil
          if images
            artist.music_images.where(:source => 'lastfm').destroy_all
            images.each do |image|
              artist.music_images.create(
                  :source => 'lastfm',
                  :image_type => 'image',
                  :size => image['size'],
                  :url => image['#text'])
            end
          end
        end

        unless tags[:hascover]
          lastfm_images = album.music_images.where(:source => 'lastfm')
          if lastfm_images.empty?
            album_info = album.mbid ? lastfm.album_info(:mbid => album.mbid) :
                lastfm.album_info(:artist => artist.name, :album => album.title)
            images = album_info['album'] ? album_info['album']['image'] : nil
            if images
              album.music_images.where(:source => 'lastfm').destroy_all
              images.each do |image|
                album.music_images.create(
                    :source => 'lastfm',
                    :image_type => 'cover',
                    :size => image['size'],
                    :url => image['#text']) if image['#text']
              end
            end
          end
        end

        if artist.music_credits.empty?
          artist_info = artist.mbid ? lastfm.artist_info(:mbid => artist.mbid) :
              lastfm.artist_info(:artist => artist.name)
          band_members = artist_info['artist'] ? artist_info['artist']['bandmembers'] : nil
          p band_members
          if band_members and band_members['member']
            if band_members['member'].is_a? Hash
              band_members['member'] = [ band_members['member'] ]
            end

            # remove dups
            credits = {}
            band_members['member'].each do |bm|
              name = bm['name']
              name.strip!
              credits[name] = bm
            end

            artist.music_credits.transaction do
              artist.music_credits.destroy_all
              credits.each do |name, band_member|
                credit = artist.music_credits.create(:job => 'Performer')
                member = MusicMember.find_or_create_by_name(name)
                member.sort_name = to_sort_name(name)
                member.save!
                member.music_credits << credit
              end
            end
          end
        end

      end
    end
  end
end

o = MusicBusiness.new
#o.scan('/data/Music/Godspeed You! Black Emperor')
#o.scan('/data/Music/Godspeed You Black Emperor!')
#o.scan('/data/Music/Tame Impala')
#o.scan('/data/Music/Clutch')
#o.scan('/data/Music/Mary Wells')
#o.scan('/data/Music/Gary Numan')
o.scan('/data/Music')


