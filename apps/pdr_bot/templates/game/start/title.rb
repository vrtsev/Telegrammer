# frozen_string_literal: true

module PdrBot
  module Templates
    module Game
      module Start
        class Title < ApplicationTemplate
          def text
            t('pdr_bot.game.start.title')
          end

          def delay
            rand(2..5)
          end
        end
      end
    end
  end
end
