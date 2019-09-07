Sequel.migration do
  change do

    add_column :example_bot_messages, :user_id, :Bignum, index: true
    execute('UPDATE example_bot_messages SET user_id=0')

    alter_table :example_bot_messages do
      set_column_not_null(:user_id)
    end

    add_column :pdr_bot_messages, :user_id, :Bignum, index: true
    execute('UPDATE pdr_bot_messages SET user_id=0')

    alter_table :pdr_bot_messages do
      set_column_allow_null(:user_id, false)
    end

    add_column :jenia_bot_messages, :user_id, :Bignum, index: true
    execute('UPDATE jenia_bot_messages SET user_id=0')

    alter_table :jenia_bot_messages do
      set_column_allow_null(:user_id, false)
    end

  end
end
