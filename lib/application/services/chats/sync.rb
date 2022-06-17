# frozen_string_literal: true

module Chats
  class Sync < BaseService
    class Contract < Dry::Validation::Contract
      params do
        required(:bot_id).filled(:integer)
        required(:autoapprove).filled(:bool)
        required(:payload).hash do
          required(:id).filled(:integer)
          required(:type).value(included_in?: Chat.chat_types.values)
          optional(:title).filled(:string)
          optional(:username).filled(:string)
          optional(:first_name).filled(:string)
          optional(:last_name).filled(:string)
          optional(:description).filled(:string)
          optional(:invite_link).filled(:string)
        end
      end
    end

    attr_reader :chat

    def call
      sync_chat
    end

    private

    def sync_chat
      @chat ||= Chat.sync_by!(:external_id, chat_params)

      logger.info "> Synced chat '#{@chat.name}'"
    end

    def chat_params
      {
        external_id: params.dig(:payload, :id),
        approved: params[:autoapprove],
        chat_type: params.dig(:payload, :type),
        title: params.dig(:payload, :title),
        username: params.dig(:payload, :username),
        first_name: params.dig(:payload, :first_name),
        last_name: params.dig(:payload, :last_name),
        description: params.dig(:payload, :description),
        invite_link: params.dig(:payload, :invite_link),
        photo_url: photo_url
      }.compact
    end

    def photo_url
      @photo_url ||= Telegram::AppManager::Client.new(bot.client).chat_photo_url(params.dig(:payload, :id))
    rescue Telegram::Bot::Error => exception
      logger.error "[Client] Error: #{exception.message}"
      nil
    end

    def bot
      @bot ||= Bot.find(params[:bot_id])
    end
  end
end
