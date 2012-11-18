class CreateMusicQueue < ActiveRecord::Migration
  def change
    create_table :music_queue do |t|
      t.references :music_song

      t.timestamps
    end
    add_index :music_queue, :music_song_id
  end
end
