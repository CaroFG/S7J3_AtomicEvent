class AddIsGodToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_god, :boolean, default: false
  end
end
