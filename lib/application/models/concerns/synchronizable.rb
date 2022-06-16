# frozen_string_literal: true

module Synchronizable
  extend ActiveSupport::Concern

  included do
    def self.sync_by!(init_attr, params)
      record = find_or_initialize_by(init_attr => params[init_attr])
      record.update!(params)

      record
    end
  end
end
