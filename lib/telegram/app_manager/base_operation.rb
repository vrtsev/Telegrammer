# frozen_string_literal: true

module Telegram
  module AppManager
    class BaseOperation < Trailblazer::Operation
      include Operation::Helpers

      def handle_validation_errors(ctx)
        return true if ctx[:validation_result].success?

        ctx[:error] = "Validation error: #{ctx[:validation_result].errors}"
        false
      end
    end
  end
end
