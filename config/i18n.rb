LOCALES_DIR_NAME = 'locales'.freeze
I18n.load_path = Dir[File.expand_path(LOCALES_DIR_NAME) + '/**/*.yml']

# Keys consistency validation
default_locale = I18n.default_locale.to_s
available_locales = I18n.available_locales.map(&:to_s)

(available_locales - Array(default_locale)).each do |locale|
  default_locale_files = Dir[File.expand_path(LOCALES_DIR_NAME) + "/#{default_locale}" + '/*.yml']
  default_locale_files.each do |default_locale_path|
    default_file = I18nSpec::LocaleFile.new(default_locale_path)
    file = I18nSpec::LocaleFile.new(default_locale_path.sub(default_locale, locale))

    @misses = default_file.flattened_translations.keys - file.flattened_translations.keys
    raise "Error. Missing translation keys in '#{file.filepath}': #{@misses}" unless @misses.empty?
  rescue Errno::ENOENT
  end
end
