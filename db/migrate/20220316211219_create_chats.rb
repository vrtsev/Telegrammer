class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.bigint :external_id, null: false
      t.boolean :approved, null: false
      t.string :chat_type, null: false
      t.string :title
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :description
      t.string :invite_link
      t.boolean :all_members_are_administrators

      t.timestamps null: false
      t.index :external_id, unique: true
    end
  end
end
