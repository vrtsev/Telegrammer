Sequel.migration do
  change do
    create_table :pdr_bot_game_rounds do

      primary_key :id
      column :chat_id,      Integer,    null: false, index: true

      column :initiator_id, Integer,    null: false
      column :loser_id,     Integer,    null: false
      column :winner_id,    Integer,    null: false

      column :created_at,   DateTime,   null: false
      column :updated_at,   DateTime,   null: false

    end
  end
end