class CreatePdrGameStats < ActiveRecord::Migration[6.1]
  def change
    create_table :pdr_game_stats do |t|
      t.integer :chat_user_id, null: false, index: true, unique: true
      t.integer :loser_count, default: 0
      t.integer :winner_count, default: 0

      t.timestamps null: false
    end
  end
end
