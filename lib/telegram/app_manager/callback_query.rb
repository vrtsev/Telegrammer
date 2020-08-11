# frozen_string_literal: true

module Telegram
  module AppManager
    class CallbackQuery

      attr_reader :params, :query

      def self.parse(query_string)
        params = JSON.parse(query_string)
        params = params.inject(Hash.new) do |hash,(key, value)|
          hash[key.to_sym] = value;
          hash
        end

        new(params)
      end

      def initialize(params)
        raise 'You need to pass hash to new callback query' unless params.is_a?(Hash)
        @params = params
      end

      def build
        @query = JSON.generate(@params)
      end

    end
  end
end
