# frozen_string_literal: true

class BasePresenter < SimpleDelegator
  def initialize(object, context=nil)
    @object = object
    @context = context

    super(@object)
  end
end
