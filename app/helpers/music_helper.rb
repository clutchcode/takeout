module MusicHelper
  def music_song_cover_path(music_song)
    if music_song.has_cover?
      cover_music_song_path(music_song)
    else
      images = music_song.music_album.music_images.where(:source => 'lastfm', :image_type => 'cover', :size => 'mega')
      if images.length > 0
        url_for(images.first)
      else
        image_path('nocover.png')
      end
    end
  end

  def music_song_cover(music_song, options = {})
    image_tag(music_song_cover_path(music_song), options)
  end

  def music_album_cover(music_album, options = {})
    music_song_cover(music_album.music_songs.first, options)
  end

  def music_album_icon(music_album, options = {})
    options[:width] ||= 100
    options[:height] ||= 100
    music_song_cover(music_album.music_songs.first, options)
  end

  def music_album_thumb(music_album, options = {})
    options[:width] ||= 100
    options[:height] ||= 100
    music_song_cover(music_album.music_songs.first, options)
  end

  def music_artist_backdrop(music_artist, options = {})
    backdrops = music_artist.music_images.where(:source => 'fanart', :image_type => 'artistbackground').order("sort_order desc")
    if backdrops.length > 0
      image_tag(url_for(backdrops.first), options)
    else
      images = music_artist.music_images.where(:image_type => 'image', :size => 'mega')
      if images.length > 0
        image_tag(url_for(images.first), options)
      else
        ""
      end
    end
  end

  def music_artist_image(music_artist, options = {})
    images = music_artist.music_images.where(:image_type => 'image', :size => 'large')
    if images.length > 0
      image_tag(url_for(images.shuffle.first), options)
    else
      ""
    end
  end

  def music_artist_large(music_artist, options = {})
    images = []
    images += music_artist.music_images.where(:image_type => 'artistthumb')
    images += music_artist.music_images.where(:image_type => 'image', :size => 'mega')

    if images.length > 0
      image = images.to_a.shuffle.first
      if image.image_type == 'artistthumb'
        # fanart artistthumbs are 1000x1000
        options[:width] ||= 500
        options[:height] ||= 500
      end
      options[:alt] ||= "#{music_artist.name} (#{pluralize images.length, 'image'})"
      image_tag(url_for(image), options)
    else
      ""
    end
  end

  def music_artist_logo(music_artist, options = {})
    images = music_artist.music_images.where(:image_type => 'musiclogo')
    if images.length > 0
      image_tag(url_for(images.first), options)
    else
      ""
    end
  end
end
