class AddCommentsToIssues < ActiveRecord::Migration
  def change
      add_column :issues, :comment_count, :integer
  end
end
