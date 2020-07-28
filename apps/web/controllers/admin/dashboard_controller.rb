module Admin
  class DashboardController < ::AdminController
    get '/' do
      @pdr_bot     = ::PdrBot::Op::Bot::State.call
      @jenia_bot   = ::JeniaBot::Op::Bot::State.call
      @example_bot = ::ExampleBot::Op::Bot::State.call
      render_html 'admin/dashboard/index'
    end
  end
end
