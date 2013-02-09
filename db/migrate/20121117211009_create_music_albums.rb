class CreateMusicAlbums < ActiveRecord::Migration
  def change
    create_table :music_albums do |t|
      t.string :title
      t.string :sort_title
      t.references :music_artist
      t.integer :year
      t.string :asin
      t.date :original_date
      t.date :release_date
      t.string :release_type
      t.string :release_country
      t.string :release_status
      t.string :mbid
      t.integer :total_tracks
      t.integer :total_length

      t.timestamps
    end
    add_index :music_albums, :music_artist_id
  end
end
