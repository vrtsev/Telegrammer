Sequel.migration do
  change do

    create_table :admin_bot_users do
      column :id,                 Integer,    unique: true, null: false, index: true
      column :role,               Integer,    default: 0
      column :username,           String,     unique: true
      column :first_name,         String
      column :last_name,          String

      column :created_at,         DateTime,   null: false
      column :updated_at,         DateTime,   null: false
    end

    create_table :admin_bot_messages do
      column :id,                 Integer,    unique: true, null: false, index: true

      # Table 'chats' skipped
      # column :chat_id,            Integer,    null: false, index: true
      column :text,               String

      column :created_at,         DateTime,   null: false
      column :updated_at,         DateTime,   null: false
    end

  end
end