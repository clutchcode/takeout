class CreateMusicArtists < ActiveRecord::Migration
  def change
    create_table :music_artists do |t|
      t.string :name
      t.string :mbid
      t.text :overview
      t.string :sort_name
      t.string :mbid

      t.timestamps
    end
  end
end
