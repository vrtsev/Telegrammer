# frozen_string_literal: true

module Telegram
  module AppManager
    class BaseController < Telegram::BotManager::Controller

      redis_url = "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}/#{ENV['REDIS_DB']}"
      self.session_store = :redis_cache_store, { url: redis_url }

    end
  end
end
