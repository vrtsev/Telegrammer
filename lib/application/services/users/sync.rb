# frozen_string_literal: true

module Users
  class Sync < BaseService
    class Contract < Dry::Validation::Contract
      params do
        optional(:bot_id).maybe(:integer)
        required(:payload).hash do
          required(:id).filled(:integer)
          optional(:username).filled(:string)
          optional(:first_name).filled(:string)
          optional(:last_name).filled(:string)
          required(:is_bot).filled(:bool)
        end
      end
    end

    attr_reader :user

    def call
      sync_user
    end

    private

    def sync_user
      @user ||= User.sync_by!(:external_id, user_params)

      logger.info "> Synced user '#{@user.name}' #{'(bot)' if @user.is_bot?}"
    end

    def user_params
      {
        external_id: params.dig(:payload, :id),
        username: params.dig(:payload, :username),
        first_name: params.dig(:payload, :first_name),
        last_name: params.dig(:payload, :last_name),
        is_bot: params.dig(:payload, :is_bot),
        bot_id: params[:bot_id]
      }
    end
  end
end
