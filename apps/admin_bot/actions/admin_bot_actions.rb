module AdminBot
  module AdminBotActions

    def admin_bot(query)
      case query.params[:action]
      when 'start!' then start!
      end
    end

    def start!
      message = AdminBot::Views::AdminBot::StartMessage.new(role: @current_admin.role)

      if payload['inline_message_id'] || payload['message']
        edit_message :text, text: message.text, reply_markup: message.markup
      else
        respond_with :message, text: message.text, reply_markup: message.markup
      end
    end

  end
end
