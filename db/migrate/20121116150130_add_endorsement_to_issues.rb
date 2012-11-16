class AddEndorsementToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :owner_endorsement, :integer, :default => 0
  end
end
