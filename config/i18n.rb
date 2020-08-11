LOCALES_DIR_NAME = 'locales'.freeze
I18n.load_path << Dir[File.expand_path(LOCALES_DIR_NAME) + '/**/*.yml']

# TODO: Implement keys validation
