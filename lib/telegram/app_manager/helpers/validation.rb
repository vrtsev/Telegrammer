# frozen_string_literal: false

module Telegram
  module AppManager
    module Helpers
      module Validation
        class ValidationError < StandardError; end

        def validate
          return unless defined?(self.class::Contract)

          result = self.class::Contract.new.call(params)
          raise ValidationError.new(result.errors.to_h) if result.errors.present?

          @params = result.to_h
        end
      end
    end
  end
end
