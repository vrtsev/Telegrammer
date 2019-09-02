# frozen_string_literal: true

module Telegram
  module AppManager
    module BaseRepositories
      module MessageRepository

        DAYS_AGO_COUNT = 90

        def delete_old(days_ago_count=DAYS_AGO_COUNT)
          model
            .where { created_at < (Date.today - days_ago_count).to_time }
            .delete
        end

      end
    end
  end
end
