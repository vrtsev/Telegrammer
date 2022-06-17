# frozen_string_literal: true

module Helpers
  module Validation
    class ValidationError < StandardError; end

    def validate!(params)
      return unless defined?(self.class::Contract)

      result = self.class::Contract.new.call(params)
      raise ValidationError.new(result.errors.to_h) if result.errors.present?

      @params = result.to_h
    end
  end
end
