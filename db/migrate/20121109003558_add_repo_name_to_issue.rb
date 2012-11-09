class AddRepoNameToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :repo_name, :string
  end
end
