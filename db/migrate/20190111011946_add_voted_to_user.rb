class AddVotedToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :voted, :text, array: true, default: []
  end
end
