# frozen_string_literal: true

Sequel.migration do
  change do
    # Example bot
    alter_table :example_bot_users do
      set_column_type :id, :Bignum
    end

    alter_table :example_bot_chats_users do
      set_column_type :user_id, :Bignum
    end

    alter_table :example_bot_auto_answers do
      set_column_type :author_id, :Bignum
    end


    # Pdr bot
    alter_table :pdr_bot_users do
      set_column_type :id, :Bignum
    end

    alter_table :pdr_bot_chats_users do
      set_column_type :user_id, :Bignum
    end

    alter_table :pdr_bot_auto_answers do
      set_column_type :author_id, :Bignum
    end


    # Jenia bot
    alter_table :jenia_bot_users do
      set_column_type :id, :Bignum
    end

    alter_table :jenia_bot_chats_users do
      set_column_type :user_id, :Bignum
    end

    alter_table :jenia_bot_auto_answers do
      set_column_type :author_id, :Bignum
    end


    # Admin bot
    alter_table :admin_bot_users do
      set_column_type :id, :Bignum
    end
  end
end
