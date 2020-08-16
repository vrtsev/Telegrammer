# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :jenia_bot_questions do
      primary_key :id

      column :chat_id,      :Bignum,    null: false, index: true
      column :text,         String,     null: false

      column :created_at,   DateTime,   null: false
      column :updated_at,   DateTime,   null: false
    end
  end
end