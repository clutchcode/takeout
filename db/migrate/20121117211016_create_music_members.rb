class CreateMusicMembers < ActiveRecord::Migration
  def change
    create_table :music_members do |t|
      t.string :name

      t.timestamps
    end
  end
end
