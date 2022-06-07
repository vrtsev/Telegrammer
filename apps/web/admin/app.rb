require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'

module Web
  class Admin < Padrino::Application
    use ConnectionPoolManagement
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Cache

    ##
    # Application configuration options
    #
    # set :raise_errors, true         # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true          # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true      # Shows a stack trace in browser (default for development)
    # set :logging, true              # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, "foo/bar"   # Location for static assets (default root/public)
    # set :reload, false              # Reload application files (default in development)
    # set :default_builder, "foo"     # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, "bar"         # Set path for I18n translations (default your_app/locales)
    # disable :sessions               # Disabled sessions by default (enable if needed)
    # disable :flash                  # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    # layout  :my_layout              # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #

    set :cache, Padrino::Cache.new(:Redis, host: ENV['REDIS_HOST'], port: ENV['REDIS_PORT'], db: ENV['REDIS_WEB_CACHE_DB'])

    enable :sessions
    enable :caching
    disable :store_location

    # Custom error management
    error(403) { @title = "Error 403"; render('layouts/error', layout: false) }
    error(404) { @title = "Error 404"; render('layouts/error', layout: false) }
    error(500) { @title = "Error 500"; render('layouts/error', layout: false) }
  end
end
