# frozen_string_literal: true

module PdrBot
  module Templates
    module Game
      module Start
        class SearchingUsers < ApplicationTemplate
          def text
            t('pdr_bot.game.start.searching_users')
          end

          def delay
            rand(1..3)
          end
        end
      end
    end
  end
end
