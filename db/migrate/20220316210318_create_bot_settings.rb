class CreateBotSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :bot_settings do |t|
      t.string :bot, null: false, index: true
      t.boolean :enabled, default: false
      t.boolean :autoapprove_chat, default: true
      t.timestamps null: false
    end
  end
end
