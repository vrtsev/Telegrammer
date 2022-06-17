class AddBotColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :bot_id, :integer
  end
end
