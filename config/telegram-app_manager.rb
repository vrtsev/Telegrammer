# frozen_string_literal: true

Telegram::AppManager.configure do |config|
  config.controller_logging = true
  config.show_app_start_message = true
end
