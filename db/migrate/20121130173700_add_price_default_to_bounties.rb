class AddPriceDefaultToBounties < ActiveRecord::Migration
  def change
    remove_column :bounties, :price
    add_column :bounties, :price, :integer, :default => 0
  end
end
