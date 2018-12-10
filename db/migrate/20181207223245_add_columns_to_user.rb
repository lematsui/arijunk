class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string
    add_column :users, :bio, :text
    add_column :users, :avatar, :string
    add_column :users, :is_admin, :boolean
  end
end
