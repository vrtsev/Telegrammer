# frozen_string_literal: true

module Avatar
  def avatar_letter
    name = @object.first_name || @object.username
    return if name.blank?

    name.first.capitalize
  end
end
