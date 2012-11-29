class CondenseUpvoteDownvoteIntoVote < ActiveRecord::Migration
  def up
    remove_column :user_votes, :downvote
    rename_column :user_votes, :upvote, :vote
  end

  def down
    add_column :user_votes, :downvote, :integer, :default => 0
    rename_column :user_votes, :vote, :upvote
  end
end
