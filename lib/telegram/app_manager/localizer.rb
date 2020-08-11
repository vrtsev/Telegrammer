# frozen_string_literal: true

module Telegram
  module AppManager
    class Localizer

      attr_accessor :locale

      def initialize(locale)
        @locale = locale
        ::I18n.locale = locale
      end

      def samples(path, params={})
        ::I18n.t(path, params.merge(default_params))
      end

      def pick(path, params={})
        samples(path, params).sample
      end

      private

      def default_params
        {
          locale: @locale
        }
      end

    end
  end
end
