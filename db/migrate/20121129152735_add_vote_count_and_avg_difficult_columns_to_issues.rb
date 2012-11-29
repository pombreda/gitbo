class AddVoteCountAndAvgDifficultColumnsToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :vote_count, :integer, :default => 0
    add_column :issues, :avg_difficulty, :float, :default => 0
  end
end
