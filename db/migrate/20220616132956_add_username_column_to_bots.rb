class AddUsernameColumnToBots < ActiveRecord::Migration[6.1]
  def change
    add_column :bots, :username, :string
  end
end
