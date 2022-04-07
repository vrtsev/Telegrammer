# frozen_string_literal: true

module Telegram
  module AppManager
    class Builder
      def self.build(**params)
        new(params).to_h
      end

      attr_reader :params

      def initialize(params)
        @params = params
      end

      def to_h
        raise "Implement method `to_h` in #{self.class}"
      end
    end
  end
end
