class RenameBotsTableBotColumnToName < ActiveRecord::Migration[6.1]
  def change
    rename_column :bots, :bot, :name
  end
end
