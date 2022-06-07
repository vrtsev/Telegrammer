# frozen_string_literal: true

class UserPresenter < BasePresenter
  include Avatar

  def type_icon_name
    @object.is_bot? ? 'robot' : 'user'
  end

  def avatar_background_class
    case @object.id.to_s.last.to_i
    when (0..1) then 'bg-primary'
    when (2..3) then 'bg-info'
    when (4..5) then 'bg-success'
    when (6..7) then 'bg-warning'
    when (8..9) then 'bg-danger'
    end
  end
end