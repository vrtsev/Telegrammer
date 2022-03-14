class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.bigint :external_id, null: false
      t.string :username
      t.string :first_name
      t.string :last_name
      t.boolean :is_bot, default: false

      t.timestamps null: false
      t.index :external_id, unique: true
    end
  end
end
