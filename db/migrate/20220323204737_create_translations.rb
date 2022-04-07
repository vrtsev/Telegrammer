class CreateTranslations < ActiveRecord::Migration[6.1]
  def change
    create_table :translations do |t|
      t.integer :chat_id # to store translation for a specific chat
      t.string :key
      t.text :values, array: true

      t.timestamps
    end
  end
end
