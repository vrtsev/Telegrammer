class AddDeletedAtColumnToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :deleted_at, :timestamp
  end
end
