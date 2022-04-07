class CreateJeniaQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :jenia_questions do |t|
      t.integer :chat_id, null: false, index: true
      t.string :text, null: false

      t.timestamps null: false
      t.index [:chat_id, :text], unique: true
    end
  end
end
