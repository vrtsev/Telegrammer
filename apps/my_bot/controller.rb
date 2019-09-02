module MyBot
  class Controller < TelegramManager::BaseController
    include ControllerHelpers

    # Connect redis to use session feature like 'session[:user_id] = user_id'
    # self.session_store = :redis_cache_store, { url: REDIS.id, namespace: ExampleBot.bot.username }

    # Action callbacks
    # before_action :callback_name

    def message(message)
      # All received telegram messages will call this method
      # respond_with(:message, text: 'Sample message text')
    end

    def start!
      # message = MyBot::Views::StartMessage.new(param: value)
      # respond_with(:message, text: message.text)
    end

    # Define your own telegram command actions here
    # Do not forget to write '!' at the end of method name
    def my_command!
      # your action code goes here
    end

    private

    # def callback_name
    #   use 'throw :abort' to exit from action
    # end

  end
end
