class CreateMusicSongs < ActiveRecord::Migration
  def change
    create_table :music_songs do |t|
      t.string :title
      t.integer :track_number
      t.integer :total_tracks
      t.integer :length
      t.boolean :vbr
      t.integer :bitrate
      t.integer :sample_rate
      t.string :channel_mode
      t.integer :disc_number
      t.integer :total_discs
      t.integer :year
      t.string :file_uri
      t.datetime :last_modified
      t.boolean :has_cover
      t.string :mbid
      t.references :music_album

      t.timestamps
    end
    add_index :music_songs, :music_album_id
  end
end
