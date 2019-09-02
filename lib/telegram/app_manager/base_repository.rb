# frozen_string_literal: true

module Telegram
  module AppManager
    class BaseRepository

      def find_all
        raise "Please, use '#paged_each' method to avoid loading all records from big tables"
      end

      def find(id)
        model.where(id: id).first
      end

      def find_or_create(id, params)
        find(id) || create(params)
      end

      def create(params)
        model.create(params)
      end

      def update(id, params)
        model.where(id: id).update(params)
      end

      def delete(id)
        model.where(id: id).delete
      end

      def count
        model.count
      end

    end
  end
end
