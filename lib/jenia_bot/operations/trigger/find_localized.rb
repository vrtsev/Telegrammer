# frozen_string_literal: true

module JeniaBot
  module Op
    module Trigger
      class FindLocalized < Telegram::AppManager::BaseOperation
        class Contract < Dry::Validation::Contract
          params do
            required(:message_text).filled(:string)
          end
        end

        pass :prepare_params
        step :validate
        step :find_trigger

        def prepare_params(ctx, params:, **)
          return unless params[:message_text].present?

          params[:message_text] = params[:message_text].strip.chomp
        end

        def validate(ctx, params:, **)
          ctx[:validation_result] = Contract.new.call(params)
          ctx[:params] = ctx[:validation_result].to_h

          handle_validation_errors(ctx)
        end

        def find_trigger(ctx, params:, **)
          samples = I18n.t('.jenia_bot.triggers')
          return unless samples.include?(params[:message_text])

          ctx[:trigger] = params[:message_text]
        end
      end
    end
  end
end
