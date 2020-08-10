# frozen_string_literal: true

module AdminBot
  module AdminBotActions
    # Router for bot callback queries
    def admin_bot_callback_query(query)
      case query.params[:action]
      when 'start!' then start!
      end
    end

    def start!
      AdminBot::Responders::AdminBot::StartMessage.new(
        role: ::AdminBot::User::Roles.key(@current_user.role),
        current_chat_id: ENV['TELEGRAM_APP_OWNER_ID']
      ).call
    end
  end
end
