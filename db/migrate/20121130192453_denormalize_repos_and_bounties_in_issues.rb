class DenormalizeReposAndBountiesInIssues < ActiveRecord::Migration
  def up
    add_column :issues, :repo_name, :string
    add_column :issues, :repo_owner, :string
    add_column :issues, :bounty_total, :integer, :default => 0
  end

  def down
    remove_column :issues, :repo_name
    remove_column :issues, :repo_owner
    remove_column :issues, :bounty_total
  end
end
