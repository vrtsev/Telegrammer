Sequel.migration do
  change do

    # create_table :my_bot_users do
    #   column :id,                 Integer,    unique: true, null: false, index: true
    #   column :username,           String
    #   column :first_name,         String
    #   column :last_name,          String

    #   column :created_at,         DateTime,   null: false
    #   column :updated_at,         DateTime,   null: false
    # end

    # create_table :my_bot_chats do
    #   column :id,                 Integer,    unique: true, null: false, index: true
    #   column :approved,           TrueClass,  default: true # Change to false if you would like to moderate suggested autoanswers
    #   column :type,               Integer,    null: false

    #   column :title,              String
    #   column :username,           String
    #   column :first_name,         String
    #   column :last_name,          String
    #   column :description,        String
    #   column :invite_link,        String

    #   column :created_at,         DateTime,   null: false
    #   column :updated_at,         DateTime,   null: false
    # end

    # create_table :my_bot_chats_users do
    #   primary_key :id

    #   column :user_id,            Integer,    null: false, index: true
    #   column :chat_id,            Integer,    null: false, index: true

    #   column :created_at,         DateTime,   null: false
    #   column :updated_at,         DateTime,   null: false

    #   unique [:user_id, :chat_id]
    # end

    # create_table :my_bot_messages do
    #   column :id,                 Integer,    unique: true, null: false, index: true
    #   column :chat_id,            Integer,    null: false, index: true
    #   column :text,               String

    #   column :created_at,         DateTime,   null: false
    #   column :updated_at,         DateTime,   null: false
    # end

    # create_table :my_bot_auto_answers do
    #   primary_key :id
    #   column :approved,           TrueClass,  default: true # Change to false if you would like to moderate suggested autoanswers

    #   column :author_id,          Integer,    null: false, index: true # For cases when smbd can suggest you autoanswer
    #   column :chat_id,            Integer,    null: false, index: true # For cases when each chat should have own autoanswers
    #   column :trigger,            String,     null: false
    #   column :answer,             String,     null: false

    #   column :created_at,         DateTime,   null: false
    #   column :updated_at,         DateTime,   null: false
    # end

  end
end