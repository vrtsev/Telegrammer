module AdminBot
  module Views
    module JeniaBot
      class AutoAnswerMessage < Telegram::AppManager::BaseView

        def markup
          {
            keyboard: params[:questions],
            resize_keyboard: true,
            one_time_keyboard: true
          }
        end

        def choose_question
          ::AdminBot.localizer.pick('jenia_bot.auto_answer.choose_question')
        end

      end
    end
  end
end
