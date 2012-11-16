class CreateUserVotes < ActiveRecord::Migration
  def change
    create_table :user_votes do |t|
      t.integer :user_id
      t.integer :issue_id
      t.integer :upvote, :default => 0
      t.integer :downvote, :default => 0

      t.timestamps
    end
  end
end
