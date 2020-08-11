module ExampleBot
  def self.find_or_create_initial_auto_answer
    auto_answer_params = {
      approved: true,
      author_id: ENV['TELEGRAM_APP_OWNER_ID'], # some rand id. it does not matter by business logic
      chat_id: ENV['TELEGRAM_APP_OWNER_ID'], # some rand id. it does not matter by business logic
      trigger: 'Hello bot',
      answer: 'Hellooo. How are you?'
    }

    unless ExampleBot::AutoAnswerRepository.new.find_by_trigger(auto_answer_params[:trigger]).present?
      ExampleBot::AutoAnswerRepository.new.create(auto_answer_params)
    end
  end
end

module AdminBot
  def self.find_or_create_initial_admin
    AdminBot::UserRepository.new.find_or_create(ENV['TELEGRAM_APP_OWNER_ID'], {
      id: ENV['TELEGRAM_APP_OWNER_ID'],
      role: AdminBot::User::Roles.administrator
    })
  end
end

ExampleBot.find_or_create_initial_auto_answer
AdminBot.find_or_create_initial_admin
