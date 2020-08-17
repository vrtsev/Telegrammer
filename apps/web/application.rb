# frozen_string_literal: false

Hanami::View.configure do
  root './apps/web/templates'
  layout :application
end
Hanami::View.load!

require_all 'apps/web/templates'
require_relative 'controllers/base_action.rb'
require_all 'apps/web/controllers'
