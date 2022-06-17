class AddAutoResponsesBotIdColumn < ActiveRecord::Migration[6.1]
  def change
    # TODO add null: false after release
    add_column :auto_responses, :bot_id, :integer
    remove_column :auto_responses, :bot
  end
end
