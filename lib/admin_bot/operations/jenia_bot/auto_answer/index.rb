# frozen_string_literal: true

module AdminBot
  module Op
    module JeniaBot
      module AutoAnswer
        class Index < Telegram::AppManager::BaseOperation
          step :find

          def find
            ctx[:auto_answers] = ::JeniaBot::AutoAnswerRepository.new.all_desc
          end
        end
      end
    end
  end
end
