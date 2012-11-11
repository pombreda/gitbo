class RemoveRepoNameFromIssues < ActiveRecord::Migration
  def up
    remove_column :issues, :repo_name
  end

  def down
    add_column :issues, :repo_name, :string
  end
end
