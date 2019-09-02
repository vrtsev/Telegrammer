module AdminBot
  module JeniaBotActions

    def jenia_bot(query)
      case query.params[:action]
      when 'start!'          then jenia_bot_start!
      when 'say!'            then jenia_bot_say!
      when 'current_state!'  then jenia_bot_current_state!
      when 'change_state!'   then jenia_bot_change_state!
      when 'question!'        then jenia_bot_question!
      when 'auto_answer!'    then jenia_bot_auto_answer!
      end
    end

    def jenia_bot_start!
      message = AdminBot::Views::JeniaBot::StartMessage.new
      edit_message :text, text: message.text, reply_markup: message.markup
    end

    def jenia_bot_say!(*message)
      message = message.join(' ')

      if message.present?
        Telegram::BotManager::Message
          .new(::JeniaBot.bot, message)
          .send_to_chat(ENV['JENIA_BOT_PUBLIC_CHAT_ID'])
      else
        save_context :jenia_bot_say!
        respond_with :message, text: 'Please, write your message'
      end
    end

    def jenia_bot_current_state!
      result = JeniaBot::Op::Bot::State.call
      return if operation_error_present?(result)

      message = AdminBot::Views::JeniaBot::CurrentStateMessage.new(state: result[:enabled])
      respond_with :message, text: message.text
    end

    def jenia_bot_change_state!
      result = AdminBot::Op::JeniaBot::ChangeState.call
      return if operation_error_present?(result)

      message = AdminBot::Views::JeniaBot::CurrentStateMessage.new(state: result[:current_state])
      respond_with :message, text: message.text
    end

    def jenia_bot_question!(*question)
      question = question.join(' ')

      if question.present?
        JeniaBot::QuestionRepository.new.create(text: question, chat_id: ENV['JENIA_BOT_PUBLIC_CHAT_ID'])
        respond_with :message, text: "Sucessfully saved new question: '#{question}'"
      else
        save_context :jenia_bot_question!
        respond_with :message, text: "Please, write new question"
      end
    end

    def jenia_bot_auto_answer!(*message)
      message = message.join(' ')

      if message.present?
        if !session[:trigger]
          session[:trigger] = message
          save_context :jenia_bot_auto_answer!
          respond_with :message, text: "Write answer for trigger '#{session[:trigger]}'"
        elsif session[:trigger] && !session[:answer]
          session[:answer] = message

          auto_answer = JeniaBot::AutoAnswerRepository.new.create(
            approved: true,
            author_id: @current_admin.id,
            chat_id: ENV['JENIA_BOT_PUBLIC_CHAT_ID'],
            trigger: session[:trigger],
            answer: session[:answer]
          )
          session[:trigger] = nil; session[:answer] = nil

          respond_with :message, text: "Saved! Trigger '#{auto_answer.trigger}' and answer: '#{auto_answer.answer}'"
        end
      else
        save_context :jenia_bot_auto_answer!
        questions = ::JeniaBot::QuestionRepository.new.get_last(9).map(&:text).each_slice(2).to_a

        message_view = AdminBot::Views::JeniaBot::AutoAnswerMessage.new(questions: questions)
        respond_with :message, text: message_view.choose_question, reply_markup: message_view.markup
      end
    end

  end
end
