module ExampleBot
  class SampleSheduledWorker < Telegram::AppManager::BaseWorker

    def perform
      puts 'Any code here'
    end

  end
end
