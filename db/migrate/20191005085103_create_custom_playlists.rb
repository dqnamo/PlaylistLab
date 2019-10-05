class CreateCustomPlaylists < ActiveRecord::Migration[5.2]
  def change
    create_table :custom_playlists do |t|
      t.string :user_id
      t.string :playlist_id
      t.timestamps
    end
  end
end
