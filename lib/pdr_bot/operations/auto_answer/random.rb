# frozen_string_literal: true

module PdrBot
  module Op
    module AutoAnswer
      class Random < Telegram::AppManager::BaseOperation
        pass :find_auto_answer
        pass :get_answer

        def find_auto_answer(ctx, **)
          ctx[:auto_answer] = PdrBot::AutoAnswerRepository.new.find_approved_random_answer(
            ctx[:chat].id,
            ctx[:message].text
          )
        end

        def get_answer(ctx, **)
          ctx[:answer] = ctx[:auto_answer].answer if ctx[:auto_answer].present?
        end
      end
    end
  end
end
