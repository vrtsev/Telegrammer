# frozen_string_literal: true

module Telegram
  module AppManager
    module BaseRepositories
      module ChatRepository

        def get_all_desc
          model.order(Sequel.desc(:created_at)).to_a
        end

      end
    end
  end
end
