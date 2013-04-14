class CreateMusicCredits < ActiveRecord::Migration
  def change
    create_table :music_credits do |t|
      t.string :credit
      t.string :department
      t.string :job
      t.references :music_album
      t.references :music_member
      t.references :music_artist

      t.timestamps
    end
    add_index :music_credits, :music_album_id
    add_index :music_credits, :music_member_id
    add_index :music_credits, :music_artist_id
  end
end
