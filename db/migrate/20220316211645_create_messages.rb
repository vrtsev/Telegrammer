class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :chat_user_id, index: true
      t.string :payload_type, null: false
      t.bigint :external_id, null: false
      t.string :text
      t.string :content_url
      t.jsonb :content_data, default: '{}'

      t.timestamps null: false
      t.index :external_id, unique: true
    end
  end
end
