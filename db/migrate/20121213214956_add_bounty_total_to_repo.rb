class AddBountyTotalToRepo < ActiveRecord::Migration
  def change
    add_column :repos, :bounty_total, :integer, :default => 0
  end
end
