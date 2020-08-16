# frozen_string_literal: true

module AdminBot
  class User < Sequel::Model(:admin_bot_users)
    class Roles
      include Ruby::Enum

      define :not_approved, 0
      define :moderator, 1
      define :administrator, 2
    end

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
