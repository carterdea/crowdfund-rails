class AddPhotoAndVideoUrlToUpdates < ActiveRecord::Migration
  def change
    add_column :updates, :photo, :string
    add_column :updates, :video_url, :string
  end
end
