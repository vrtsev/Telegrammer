class CreateAutoResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :auto_responses do |t|
      t.integer :author_id, null: false, index: true
      t.integer :chat_id, null: false, index: true
      t.string :bot, null: false, index: true
      t.text :trigger, null: false
      t.text :response, null: false

      t.timestamps null: false
    end
  end
end
