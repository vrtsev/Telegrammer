# frozen_string_literal: true

module ExampleBot
  module Templates
    class ApplicationTemplate < Telegram::AppManager::Template
      include Helpers::Validation
      include Helpers::Translation

      def self.build(**params)
        instance = new(params)
        instance.validate!(params)
        instance.to_h
      end
    end
  end
end
