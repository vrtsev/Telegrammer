# frozen_string_literal: false

class BaseAction
  private

  def render(view_class, format: :html, **params)
    self.body = view_class.render(format: format, **params)
  end
end
