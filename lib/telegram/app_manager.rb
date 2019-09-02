require_relative "app_manager/extensions/object_extension.rb"
require_relative "app_manager/logger.rb"
require_relative "app_manager/operation/helpers.rb"
require_relative "app_manager/operation/macros.rb"
require_relative "app_manager/base_operation.rb"
require_relative "app_manager/base_view.rb"
require_relative "app_manager/base_repository.rb"
require_relative "app_manager/base_worker.rb"
require_relative "app_manager/base_controller.rb"

require_all('./lib/telegram/app_manager/base_models')
require_all('./lib/telegram/app_manager/base_repositories')

module Telegram
  module AppManager
  end
end
