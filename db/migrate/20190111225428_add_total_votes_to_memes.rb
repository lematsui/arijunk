class AddTotalVotesToMemes < ActiveRecord::Migration[5.2]
  def change
    add_column :memes, :total_votes, :integer
  end
end
