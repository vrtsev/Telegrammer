# frozen_string_literal: false

module Admin
  module DashboardController
    class Index < BaseAction
      include Hanami::Action

      def call(params)
        render(Admin::Dashboard::Index)
      end
    end
  end
end
