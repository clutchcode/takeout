class CreateMusicImages < ActiveRecord::Migration
  def change
    create_table :music_images do |t|
      t.string :source
      t.string :url
      t.string :size
      t.float :aspect_ratio
      t.integer :width
      t.integer :height
      t.string :language
      t.integer :sort_order
      t.string :image_type
      t.references :music_artist
      t.references :music_album

      t.timestamps
    end
    add_index :music_images, :music_artist_id
    add_index :music_images, :music_album_id
  end
end
