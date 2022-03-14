# frozen_string_literal: false

module Telegram
  module AppManager
    class Service
      include Helpers::Logging
      include Helpers::Validation

      class ServiceError < StandardError
        attr_reader :error_code

        def initialize(error_code:)
          @error_code = error_code
          super
        end
      end

      def self.call(params = {})
        new(params)
      end

      attr_reader :params, :success, :exception

      alias success? success

      def initialize(params = {})
        @exception = nil
        @success = true
        @params = params

        validate
        call
      rescue ServiceError => exception
        @success, @exception = false, exception
      end

      def call
        raise NotImplementedError, "class #{self.class.name} must implement abstract method 'call()'"
      end
    end
  end
end
