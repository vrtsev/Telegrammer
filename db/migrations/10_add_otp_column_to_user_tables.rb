Sequel.migration do
  up do
    # Admin bot
    add_column :admin_bot_users, :otp_secret, String

    # Example bot
    add_column :example_bot_users, :otp_secret, String

    # Pdr bot
    add_column :pdr_bot_users, :otp_secret, String

    # Jenia bot
    add_column :jenia_bot_users, :otp_secret, String
  end

  down do
    drop_column :admin_bot_users,   :otp_secret
    drop_column :example_bot_users, :otp_secret
    drop_column :pdr_bot_users,     :otp_secret
    drop_column :jenia_bot_users,   :otp_secret
  end
end