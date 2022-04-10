# frozen_string_literal: true

module PdrGame
  class Run < Telegram::AppManager::Service
    class Contract < Telegram::AppManager::Contract
      params do
        required(:chat_id).filled(:integer)
        required(:initiator_id).filled(:integer)
      end
    end

    MINIMUM_USER_COUNT = 2

    attr_reader :game_round

    def call
      ActiveRecord::Base.transaction do
        check_latest_round_expired
        check_minimum_user_count
        update_stats
        save_game_round
      end
    end

    private

    def check_latest_round_expired
      return true if last_game_round.nil?
      return true if Date.today.day != last_game_round.updated_at.day

      raise ServiceError.new(error_code: 'PDR_GAME_LATEST_ROUND_NOT_EXPIRED')
    end

    def check_minimum_user_count
      users_count = ChatUser.where(chat_id: params[:chat_id], deleted_at: nil).count
      return true if users_count >= MINIMUM_USER_COUNT

      raise ServiceError.new(error_code: 'PDR_GAME_NOT_ENOUGH_USERS')
    end

    def update_stats
      @winner_stat = winner.pdr_game_stat.increment!(:winner_count)
      @loser_stat = loser.pdr_game_stat.increment!(:loser_count)
    end

    def save_game_round
      @game_round = current_chat.pdr_game_round
      @game_round.update!(
        initiator_id: params[:initiator_id],
        winner_id: winner.user_id,
        loser_id: loser.user_id
      )

      @game_round
    end

    def last_game_round
      @last_game_round ||= PdrGame::Round.order(created_at: :desc).find_by(chat_id: params[:chat_id])
    end

    def finalists
      @finalists ||= ChatUser
        .where(chat_id: params[:chat_id], deleted_at: nil)
        .order("RANDOM()")
        .limit(2)
        .to_a
    end

    def winner
      @winner ||= finalists.first
    end

    def loser
      @loser ||= finalists.last
    end

    def current_chat
      @current_chat ||= Chat.find(params[:chat_id])
    end
  end
end
