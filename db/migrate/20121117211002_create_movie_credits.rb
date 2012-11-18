class CreateMovieCredits < ActiveRecord::Migration
  def change
    create_table :movie_credits do |t|
      t.string :job
      t.string :department
      t.string :character
      t.integer :sort_order
      t.references :movie
      t.references :movie_member

      t.timestamps
    end
    add_index :movie_credits, :movie_id
    add_index :movie_credits, :movie_member_id
  end
end
