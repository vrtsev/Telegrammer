# frozen_string_literal: true

Web::Admin.helpers do
  def sync_bot_user(bot)
    bot_payload = Telegram::AppManager::Client.new(bot.client).get_bot
    Users::Sync.call(bot_id: bot.id, payload: bot_payload).user
  end

  def present(model, presenter_class=nil)
    klass = presenter_class || "#{model.class}Presenter".constantize
    presenter = klass.new(model, self)
    yield(presenter) if block_given?

    presenter
  end

  def present_collection(collection, presenter_class=nil)
    return [] if collection.blank?

    collection.map { |record| present(record, presenter_class) }
  end

  def format_datetime(datetime)
    return "Today at #{format_time(datetime)}" if datetime.to_date.today?
    return "Yesterday at #{format_time(datetime)}" if datetime.to_date.yesterday?

    datetime.strftime('%d.%m.%y %H:%M')
  end

  def format_date_or_time(datetime)
    return format_time(datetime) if datetime.to_date.today?

    format_date(datetime)
  end

  def format_time(datetime)
    datetime.strftime('%H:%M')
  end

  def format_date(datetime)
    return 'Today' if datetime.to_date.today?
    return 'Yesterday' if datetime.to_date.yesterday?
    return datetime.strftime('%A') if datetime.to_date.cweek == Date.today.cweek

    datetime.strftime('%d.%m.%y')
  end

  def next_item_of(collection, current_index)
    collection[current_index + 1]
  end
end
