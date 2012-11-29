class AddCollectedByToBounty < ActiveRecord::Migration
  def change
    add_column :bounties, :collected_by_user_id, :integer, :default => 0
  end
end
