# frozen_string_literal: true

class BaseWorker
  include Sidekiq::Worker
  include Helpers::Logging

  def perform
    raise "Implement method `perform` in #{self.class}"
  end

  private

  def handle_service_error(exception)
    raise("'#{Rainbow(self.class.to_s).bold.red}' has service error: #{exception.error_code}")
  end
end
