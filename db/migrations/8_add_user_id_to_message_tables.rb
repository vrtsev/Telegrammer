Sequel.migration do
  change do

    alter_table :example_bot_messages do
      add_column :user_id, :Bignum, index: true
      dataset.from(:example_bot_messages).update(user_id: 0)
      set_column_allow_null(:user_id, false)
    end

    alter_table :pdr_bot_messages do
      add_column :user_id, :Bignum, index: true
      dataset.from(:pdr_bot_messages).update(user_id: 0)
      set_column_allow_null(:user_id, false)
    end

    alter_table :jenia_bot_messages do
      add_column :user_id, :Bignum, index: true
      dataset.from(:jenia_bot_messages).update(user_id: 0)
      set_column_allow_null(:user_id, false)
    end

  end
end