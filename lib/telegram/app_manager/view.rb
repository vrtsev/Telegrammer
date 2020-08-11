# frozen_string_literal: true

module Telegram
  module AppManager
    class View

      attr_reader :params, :content

      def initialize(params={})
        raise 'You need to pass hash to new view' unless params.is_a?(Hash)

        @params = params
        @content = String.new
        @markup = Hash.new
      end

      private

      def callback_data(**params)
        CallbackQuery.new(params).build
      end

    end
  end
end
