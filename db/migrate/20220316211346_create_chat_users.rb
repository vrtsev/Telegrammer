class CreateChatUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_users do |t|
      t.integer :user_id, null: false
      t.integer :chat_id, null: false
      t.datetime :deleted_at

      t.timestamps null: false
      t.index [:user_id, :chat_id], unique: true
    end
  end
end
