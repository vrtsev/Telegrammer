module ExampleBot
  class SampleSheduledWorker < Telegram::AppManager::BaseWorker

    def perform
      result = ExampleBot::Op::Message::DeleteOld.call
      handle_operation_errors(result[:error]) if result.failure?
    end

  end
end
