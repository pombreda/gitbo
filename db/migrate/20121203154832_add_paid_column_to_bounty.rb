class AddPaidColumnToBounty < ActiveRecord::Migration
  def change
    add_column :bounties, :paid, :boolean, :default => false
  end
end
