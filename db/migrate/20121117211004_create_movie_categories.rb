class CreateMovieCategories < ActiveRecord::Migration
  def change
    create_table :movie_categories do |t|
      t.references :movie
      t.references :movie_genre
    end
  end
end
