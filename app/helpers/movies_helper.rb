module MoviesHelper
  def movie_image(image, options = {})
    if image and image.url
      image_tag(url_for(image), options)
    else
      ""
    end
  end

  def movie_thumb(movie, options = {})
    movie_image(movie.thumb, options)
  end

  def movie_cover(movie, options = {})
    movie_image(movie.cover, options)
  end

  def movie_backdrop(movie, options = {})
    movie_image(movie.backdrops.shuffle.first, options)
  end

  def movie_poster(movie, options = {})
    movie_image(movie.posters.shuffle.first, options)
  end

  def member_thumb(member, options = {})
    movie_image(member.thumb, options)
  end

  def member_profile(member, options = {})
    movie_image(member.profile, options)
  end

  def collection_thumb(collection, options = {})
    movie_image(collection.thumb, options)
  end

  def collection_cover(collection, options = {})
    movie_image(collection.cover, options)
  end

  def collection_backdrop(collection, options = {})
    movie_image(collection.backdrops.shuffle.first, options)
  end

  def collection_poster(collection, options = {})
    movie_image(collection.posters.shuffle.first, options)
  end
end
