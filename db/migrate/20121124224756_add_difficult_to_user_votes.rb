class AddDifficultToUserVotes < ActiveRecord::Migration
  def change
    add_column :user_votes, :difficulty_rating, :integer, :default => 0
  end
end
