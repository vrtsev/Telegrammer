# frozen_string_literal: true

module Synchronizable
  extend ActiveSupport::Concern

  included do
    def self.sync(params, **init_attrs)
      record = find_or_initialize_by(init_attrs)
      record.update!(params)

      record
    end
  end
end
