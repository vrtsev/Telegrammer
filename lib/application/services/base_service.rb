# frozen_string_literal: false

class BaseService
  include Helpers::Validation
  include Helpers::Logging

  class ServiceError < StandardError
    attr_reader :error_code

    def initialize(error_code:)
      @error_code = error_code
      super
    end
  end

  def self.call(params = {})
    instance = new(**params)
    instance.validate!(params)
    instance.call

    instance
  rescue ServiceError => exception
    instance.fail!(exception)
  end

  attr_reader :params, :success, :exception

  alias success? success

  def initialize(params = {})
    @exception = nil
    @success = true
    @params = params
  end

  def call
    raise NotImplementedError, "class #{self.class.name} must implement abstract method 'call()'"
  end

  def fail!(exception = nil)
    @success, @exception = false, exception
    self
  end
end
