class CreateMovieCollections < ActiveRecord::Migration
  def change
    create_table :movie_collections do |t|
      t.string :name
      t.string :sort_name

      t.timestamps
    end
  end
end
