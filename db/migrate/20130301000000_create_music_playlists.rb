class CreateMusicPlaylists < ActiveRecord::Migration
  def change
    create_table :music_playlists do |t|
      t.string :name
      t.string :sort_name

      t.timestamps
    end
  end
end

# music_song
# music_artist
# music_genre

