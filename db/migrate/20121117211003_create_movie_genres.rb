class CreateMovieGenres < ActiveRecord::Migration
  def change
    create_table :movie_genres do |t|
      t.string :name

      t.timestamps
    end
  end
end
