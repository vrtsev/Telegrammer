class RenameBotSettingsToBots < ActiveRecord::Migration[6.1]
  def change
    rename_table :bot_settings, :bots
  end
end
