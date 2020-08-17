# frozen_string_literal: true

require 'rotp'

Sequel.migration do
  ROWS_PER_FETCH = 100

  up do
    # Example bot
    dataset.from(:example_bot_users).paged_each(rows_per_fetch: ROWS_PER_FETCH) do |user|
      dataset.from(:example_bot_users).where(id: user[:id]).update(otp_secret: ROTP::Base32.random_base32)
    end

    # Pdr bot
    dataset.from(:pdr_bot_users).paged_each(rows_per_fetch: ROWS_PER_FETCH) do |user|
      dataset.from(:pdr_bot_users).where(id: user[:id]).update(otp_secret: ROTP::Base32.random_base32)
    end

    # Jenia bot
    dataset.from(:jenia_bot_users).paged_each(rows_per_fetch: ROWS_PER_FETCH) do |user|
      dataset.from(:jenia_bot_users).where(id: user[:id]).update(otp_secret: ROTP::Base32.random_base32)
    end

    # Admin bot
    dataset.from(:admin_bot_users).paged_each(rows_per_fetch: ROWS_PER_FETCH) do |user|
      dataset.from(:admin_bot_users).where(id: user[:id]).update(otp_secret: ROTP::Base32.random_base32)
    end
  end

  down do
  end
end
