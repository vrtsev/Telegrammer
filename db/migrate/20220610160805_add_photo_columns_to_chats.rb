class AddPhotoColumnsToChats < ActiveRecord::Migration[6.1]
  def change
    add_column :chats, :photo_url, :string
  end
end
