class ChangeMessagesExternalIdIdxToComposite < ActiveRecord::Migration[6.1]
  def change
    remove_index :messages, :external_id
    add_index :messages, [:external_id, :bot_id], unique: true
  end
end
