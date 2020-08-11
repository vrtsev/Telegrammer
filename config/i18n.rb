I18n.load_path << Dir[File.expand_path(ENV['LOCALES_DIR_NAME']) + '/*.yml']

# Validate custom locales with default locales keyset
DEFAULT_LOCALES_DIR_NAME = 'locales'.freeze
Dir[File.expand_path(DEFAULT_LOCALES_DIR_NAME) + '/*.yml'].each do |locale_path|
  locale_file = I18nSpec::LocaleFile.new(locale_path.sub(DEFAULT_LOCALES_DIR_NAME, ENV['LOCALES_DIR_NAME']))
  default_locale = I18nSpec::LocaleFile.new(locale_path)
  @misses = default_locale.flattened_translations.keys - locale_file.flattened_translations.keys

  raise "Error. Missing translation keys in '#{locale_file}': #{@misses}" unless @misses.empty?
end
