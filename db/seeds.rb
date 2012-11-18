# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#movie = Movie.create(title: 'Test Movie', released: '1999-1-1', runtime: 123, url: 'file:')

movie = Movie.find(1)

movie.movie_posters.create(:url => 'http://foo.com/poster.jpg', size: 'thumb')
p movie
p movie.movie_posters



