module JeniaBot
  module Views
    class Questions < Telegram::AppManager::BaseView

      KEYBOARD_SLICE_COUNT = 1

      def markup
        {
          keyboard: params[:questions].each_slice(KEYBOARD_SLICE_COUNT).to_a,
          resize_keyboard: true,
          one_time_keyboard: true
        }
      end

      def text
        ::JeniaBot.localizer.pick('trigger_answer')
      end

    end
  end
end
