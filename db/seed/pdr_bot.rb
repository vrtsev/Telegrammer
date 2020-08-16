# frozen_string_literal: true

# Create test user for PdrBot
test_user_id = 123_456
PdrBot::UserRepository.new.create(id: test_user_id, name: 'test_user_1', first_name: 'Test', last_name: 'User 1')
PdrBot::ChatUserRepository.new.create(user_id: test_user_id, chat_id: ENV['TELEGRAM_APP_OWNER_ID'])
