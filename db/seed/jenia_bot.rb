# frozen_string_literal: true

# Create test user
test_user_id = 123_456
JeniaBot::UserRepository.new.create(id: test_user_id, name: 'test_user_1', first_name: 'Test', last_name: 'User 1')
JeniaBot::ChatUserRepository.new.create(user_id: test_user_id, chat_id: ENV['TELEGRAM_APP_OWNER_ID'])

# Create test questions
QUESTIONS_ANSWERS = [
  { question: 'How are you?',         answers: ['I am ok', 'Everything is ok'] },
  { question: 'What do you do?',      answers: ['I am preparing homework', 'Watching TV'] },
  { question: 'What have you done?',  answers: ['Nothing...', 'I had a lot of tasks'] }
].freeze

QUESTIONS_ANSWERS.each do |data|
  JeniaBot::QuestionRepository.new.create(chat_id: ENV['TELEGRAM_APP_OWNER_ID'], text: data[:question])

  data[:answers].each do |answer|
    JeniaBot::AutoAnswerRepository.new.create(
      approved: true,
      author_id: ENV['TELEGRAM_APP_OWNER_ID'],
      chat_id: ENV['TELEGRAM_APP_OWNER_ID'],
      trigger: data[:question],
      answer: answer
    )
  end
end
