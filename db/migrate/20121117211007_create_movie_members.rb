class CreateMovieMembers < ActiveRecord::Migration
  def change
    create_table :movie_members do |t|
      t.string :name

      t.timestamps
    end
  end
end
