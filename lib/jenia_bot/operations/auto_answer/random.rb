module JeniaBot
  module Op
    module AutoAnswer
      class Random < Telegram::AppManager::BaseOperation

        pass :find_trigger_message
        pass :get_answer

        def find_trigger_message(ctx, **)
          ctx[:auto_answer] = JeniaBot::AutoAnswerRepository.new.find_approved_random_answer(ctx[:chat].id, ctx[:message].text)
        end

        def get_answer(ctx, **)
          ctx[:answer] = ctx[:auto_answer].answer if ctx[:auto_answer].present?
        end

      end
    end
  end
end
