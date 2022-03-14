# frozen_string_literal: true

def db_configuration
  db_configuration_file = File.join('db', 'config.yml')
  YAML.load(ERB.new(File.read(db_configuration_file)).result, aliases: true)
end

ActiveRecord::Base.logger = Telegram::AppManager::Logger.new('log/database.log')
ActiveRecord::Base.logger.formatter = Telegram::AppManager::Logger::ActiveRecordFormatter.new
ActiveRecord::Base.establish_connection(db_configuration[ENV['APP_ENV']])
