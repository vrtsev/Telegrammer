module AdminBot
  module PdrBotActions

    def pdr_bot(query)
      case query.params[:action]
      when 'start!'          then pdr_bot_start!
      when 'current_state!'  then pdr_bot_current_state!
      when 'change_state!'   then pdr_bot_change_state!
      when 'say!'            then pdr_bot_say!
      when 'auto_answer!'    then pdr_bot_auto_answer!
      end
    end

    def pdr_bot_start!
      message = AdminBot::Views::PdrBot::StartMessage.new
      edit_message :text, text: message.text, reply_markup: message.markup
    end

    def pdr_bot_say!(*message)
      message = message.join(' ')

      if message.present?
        Telegram::BotManager::Message
          .new(::PdrBot.bot, message)
          .send_to_chat(ENV['PDR_BOT_PUBLIC_CHAT_ID'])
      else
        save_context :pdr_bot_say!
        respond_with :message, text: 'Please, write your message'
      end
    end

    def pdr_bot_current_state!
      result = PdrBot::Op::Bot::State.call
      return if operation_error_present?(result)

      message = AdminBot::Views::PdrBot::CurrentStateMessage.new(state: result[:enabled])
      respond_with :message, text: message.text
    end

    def pdr_bot_change_state!
      result = AdminBot::Op::PdrBot::ChangeState.call
      return if operation_error_present?(result)

      message = AdminBot::Views::PdrBot::CurrentStateMessage.new(state: result[:current_state])
      respond_with :message, text: message.text
    end

    def pdr_bot_auto_answer!(*message)
      message = message.join(' ')

      if message.present?
        if !session[:trigger]
          session[:trigger] = message
          save_context :pdr_bot_auto_answer!
          respond_with :message, text: "Write answer for trigger '#{session[:trigger]}'"
        elsif session[:trigger] && !session[:answer]
          session[:answer] = message

          auto_answer = PdrBot::AutoAnswerRepository.new.create(
            author_id: @current_admin.id,
            approved: true,
            chat_id: ENV['PDR_BOT_PUBLIC_CHAT_ID'],
            trigger: session[:trigger],
            answer: session[:answer]
          )
          session[:trigger] = nil; session[:answer] = nil

          respond_with :message, text: "Saved! Trigger '#{auto_answer.trigger}' and answer: '#{auto_answer.answer}'"
        end
      else
        save_context :pdr_bot_auto_answer!
        respond_with :message, text: "Please, write your trigger"
      end
    end

  end
end
