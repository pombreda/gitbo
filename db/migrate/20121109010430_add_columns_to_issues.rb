class AddColumnsToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :repo_name, :string
    add_column :issues, :issue_author, :string
    add_column :issues, :state, :string
    add_column :issues, :git_comments, :integer

  end
end
