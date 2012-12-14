class CreateMovieMembers < ActiveRecord::Migration
  def change
    create_table :movie_members do |t|
      t.string :name
      t.string :sort_name
      t.string :tmdb_id

      t.timestamps
    end
  end
end
