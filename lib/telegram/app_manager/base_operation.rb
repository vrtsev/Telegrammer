# frozen_string_literal: true

module Telegram
  module AppManager
    class BaseOperation < Trailblazer::Operation
      private

      def merge_operation_result(result, ctx, keys=[])
        keys.each { |key| ctx[key] = result[key] }
        ctx
      end

      def operation_error(ctx, error_msg)
        ctx[:error] = error_msg

        # Hacky return false to route operation to :failure track
        # if step is ending on add_error
        false
      end

      def handle_validation_errors(ctx)
        return true if ctx[:validation_result].success?

        ctx[:error] = "Validation error: #{ctx[:validation_result].errors}"
        false
      end
    end
  end
end
