module AdminBot
  module ExampleBotActions

    def example_bot(query)
      case query.params[:action]
      when 'start!'          then example_bot_start!
      when 'current_state!'  then example_bot_current_state!
      when 'change_state!'   then example_bot_change_state!
      when 'question!'       then example_bot_question!
      when 'auto_answer!'    then example_bot_auto_answer!
      end
    end

    def example_bot_start!
      message = AdminBot::Views::ExampleBot::StartMessage.new
      edit_message :text, text: message.text, reply_markup: message.markup
    end

    def example_bot_current_state!
      result = ExampleBot::Op::Bot::State.call
      return if operation_error_present?(result)

      message = AdminBot::Views::ExampleBot::CurrentStateMessage.new(state: result[:enabled])
      respond_with :message, text: message.text
    end

    def example_bot_change_state!
      result = AdminBot::Op::ExampleBot::ChangeState.call
      return if operation_error_present?(result)

      message = AdminBot::Views::ExampleBot::CurrentStateMessage.new(state: result[:current_state])
      respond_with :message, text: message.text
    end

    def example_bot_auto_answer!(*message)
      message = message.join(' ')

      if message.present?
        if !session[:trigger]
          session[:trigger] = message
          save_context :example_bot_auto_answer!
          respond_with :message, text: "Write answer for trigger '#{session[:trigger]}'"
        elsif session[:trigger] && !session[:answer]
          session[:answer] = message

          auto_answer = ExampleBot::AutoAnswerRepository.new.create(
            approved: true,
            author_id: @current_admin.id,
            chat_id: 999999, # Some rand id. it does not matter by business logic
            trigger: session[:trigger],
            answer: session[:answer]
          )
          session[:trigger] = nil; session[:answer] = nil

          respond_with :message, text: "Saved! Trigger '#{auto_answer.trigger}' and answer: '#{auto_answer.answer}'"
        end
      else
        save_context :example_bot_auto_answer!
        respond_with :message, text: "Please, write your trigger"
      end
    end

  end
end
