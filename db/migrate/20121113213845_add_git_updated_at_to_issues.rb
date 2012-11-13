class AddGitUpdatedAtToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :git_updated_at, :datetime
  end
end
