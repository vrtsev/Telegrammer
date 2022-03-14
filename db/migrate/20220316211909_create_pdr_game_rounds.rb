class CreatePdrGameRounds < ActiveRecord::Migration[6.1]
  def change
    create_table :pdr_game_rounds do |t|
      t.integer :chat_id, null: false, index: true
      t.integer :initiator_id, null: false
      t.integer :loser_id, null: false
      t.integer :winner_id, null: false

      t.timestamps null: false
    end
  end
end
