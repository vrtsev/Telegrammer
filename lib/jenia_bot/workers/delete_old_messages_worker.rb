module JeniaBot
  class DeleteOldMessagesWorker < Telegram::AppManager::BaseWorker

    def perform
      result = JeniaBot::Op::Message::DeleteOld.call
      handle_operation_errors(result[:error]) if result.failure?
    end

  end
end
