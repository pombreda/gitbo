class AddupvotedownvoteToIssues < ActiveRecord::Migration
  def up
    add_column :issues, :upvote, :integer
    add_column :issues, :downvote, :integer
  end

  def down
    remove_column :issues, :upvote
    remove_column :issues, :downvote
  end
end
