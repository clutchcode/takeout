class CreateMovieImages < ActiveRecord::Migration
  def change
    create_table :movie_images do |t|
      t.string :source
      t.string :url
      t.string :size
      t.float :aspect_ratio
      t.integer :width
      t.integer :height
      t.string :language
      t.integer :sort_order
      t.string :image_type
      t.references :movie
      t.references :movie_collection
      t.references :movie_member

      t.timestamps
    end
    add_index :movie_images, :movie_id
    add_index :movie_images, :movie_collection_id
    add_index :movie_images, :movie_member_id
  end
end
