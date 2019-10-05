class CreateEnhancePlaylists < ActiveRecord::Migration[5.2]
  def change
    create_table :enhance_playlists do |t|
      t.string :playlist_id
      t.text :tracks
      t.timestamps
    end
  end
end
