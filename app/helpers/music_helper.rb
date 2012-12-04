module MusicHelper
  def music_song_cover(music_song, options = {})
    if music_song.has_cover?
      image_tag(cover_music_song_path(music_song), options)
    else
      image_tag('/nocover.png', options)
    end
  end

  def music_album_cover(music_album, options = {})
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
      image_tag(url_for(images.first), options)
    else
      ""
    end
  end

  def music_artist_large(music_artist, options = {})
    #images = music_artist.music_images.where(:image_type => 'artistthumb')
    images = music_artist.music_images.where(:image_type => 'image', :size => 'mega') # if images.length == 0
    if images.length > 0
      image_tag(url_for(images.first), options)
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
