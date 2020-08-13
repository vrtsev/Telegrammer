module AdminBot
  class DeleteOldMessagesWorker < Telegram::AppManager::BaseWorker
    def perform
      result = AdminBot::Op::Message::DeleteOld.call
      handle_operation_errors(result[:error]) if result.failure?
    end
  end
end
