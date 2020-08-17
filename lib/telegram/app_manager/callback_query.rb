# frozen_string_literal: true

module Telegram
  module AppManager
    class CallbackQuery
      def self.parse(query_string)
        params = JSON.parse(query_string)
        params = params.each_with_object({}) do |(key, value), hash|
          hash[key.to_sym] = value
          hash
        end

        new(params)
      end

      attr_reader :params, :query

      def initialize(**params)
        @params = params
      end

      def build
        @query = JSON.generate(params)
      end
    end
  end
end
