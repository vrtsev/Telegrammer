module Admin
  class DashboardController < AdminController
    def index
      @pdr_bot     = ::PdrBot::Op::Bot::State.call
      @jenia_bot   = ::JeniaBot::Op::Bot::State.call
      @example_bot = ::ExampleBot::Op::Bot::State.call
    end
  end
end
