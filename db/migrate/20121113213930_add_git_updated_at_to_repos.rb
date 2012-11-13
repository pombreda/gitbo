class AddGitUpdatedAtToRepos < ActiveRecord::Migration
  def change
    add_column :repos, :git_updated_at, :datetime
  end
end
