class CreateMusicCategories < ActiveRecord::Migration
  def change
    create_table :music_categories do |t|
      t.references :music_genre
      t.references :music_song

      t.timestamps
    end
    add_index :music_categories, :music_genre_id
    add_index :music_categories, :music_song_id
  end
end
