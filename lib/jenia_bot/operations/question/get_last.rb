# frozen_string_literal: true

module JeniaBot
  module Op
    module Question
      class GetLast < Telegram::AppManager::BaseOperation
        QUESTIONS_COUNT = 9

        pass :find_triggers
        pass :map_triggers

        def find_triggers(ctx, **)
          ctx[:questions] = ::JeniaBot::QuestionRepository.new.get_last(QUESTIONS_COUNT)
        end

        def map_triggers(ctx, **)
          ctx[:questions] = ctx[:questions].map(&:text)
        end
      end
    end
  end
end
