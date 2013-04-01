class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :sort_title
      t.string :original_title
      t.string :file_uri
      t.string :rating
      t.integer :runtime
      t.date :release_date
      t.string :imdb_id
      t.string :tmdb_id
      t.text :overview
      t.text :tagline
      t.datetime :last_modified
      t.references :movie_collection

      t.timestamps
    end
  end
end
