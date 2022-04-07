# frozen_string_literal: true

module Telegram
  module AppManager
    module Builders
      class Chat < Builder
        def to_h
          {
            external_id: params[:chat].id,
            approved: params[:bot_setting].autoapprove_chat,
            chat_type: params[:chat].type,
            title: params[:chat].title,
            username: params[:chat].username,
            first_name: params[:chat].first_name,
            last_name: params[:chat].last_name,
            description: params[:chat].description,
            invite_link: params[:chat].invite_link,
            all_members_are_administrators: params[:chat].all_members_are_administrators
          }
        end
      end
    end
  end
end
