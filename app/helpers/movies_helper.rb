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
    movie_image(movie.backdrop, options)
  end

  def member_thumb(member, options = {})
    movie_image(member.thumb, options)
  end

  def member_profile(member, options = {})
    movie_image(member.profile, options)
  end
end
