class AddBotColumnToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :bot_id, :integer
  end
end
