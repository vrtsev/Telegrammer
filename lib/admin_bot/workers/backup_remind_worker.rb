module AdminBot
  class BackupRemindWorker < Telegram::AppManager::BaseWorker

    def perform
      result = AdminBot::Op::Reminder::DatabaseBackup.call
      handle_operation_errors(result[:error]) if result.failure?
    end

  end
end
