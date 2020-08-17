# frozen_string_literal: true

module ExampleBot
  class DeleteOldMessagesWorker < Telegram::AppManager::BaseWorker
    def perform
      result = ExampleBot::Op::Message::DeleteOld.call
      handle_operation_errors(result[:error]) if result.failure?
    end
  end
end
