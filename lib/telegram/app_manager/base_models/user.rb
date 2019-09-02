# frozen_string_literal: true

module Telegram
  module AppManager
    module BaseModels
      module User

        def full_name
          if first_name && last_name
            "#{first_name} #{last_name}"
          elsif first_name || last_name
            first_name || last_name
          else
            username
          end
        end

      end
    end
  end
end
