class AddSearchColumnsToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :repo_owner, :string
    add_column :issues, :issue_number, :integer

  end
end
