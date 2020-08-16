# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :pdr_bot_stats do
      primary_key :id

      column :chat_id,      :Bignum,    null: false
      column :user_id,      Integer,    null: false

      column :loser_count,  Integer,    default: 0
      column :winner_count, Integer,    default: 0

      column :created_at,   DateTime,   null: false
      column :updated_at,   DateTime,   null: false
    end
  end
end
