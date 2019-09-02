# frozen_string_literal: true

module Telegram
  module AppManager
    class BaseOperation < Trailblazer::Operation
      include Operation::Helpers
    end
  end
end
