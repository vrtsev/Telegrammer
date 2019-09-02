module PdrBot
  class BookTableRemindWorker < Telegram::AppManager::BaseWorker

    def perform
      result = PdrBot::Op::Reminder::BookTable.call
      handle_operation_errors(result[:error]) if result.failure?
    end

  end
end
