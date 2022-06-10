class AddPhotoColumnsToChats < ActiveRecord::Migration[6.1]
  def change
    add_column :chats, :photo_url, :string
    add_column :chats, :photo_thumb_url, :string
  end
end
