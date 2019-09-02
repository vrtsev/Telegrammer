module JeniaBot
  class QuestionRepository < Telegram::AppManager::BaseRepository

    def find_by_text(text)
      model
        .where(text: text)
        .first
    end

    def get_last(limit=1)
      model
        .limit(limit)
        .order(Sequel.desc(:created_at))
        .to_a
    end

    private

    def model
      JeniaBot::Question
    end

  end
end
