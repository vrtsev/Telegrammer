class AddAutoResponsesBotIdColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :auto_responses, :bot_id, :integer
    remove_column :auto_responses, :bot
  end
end
