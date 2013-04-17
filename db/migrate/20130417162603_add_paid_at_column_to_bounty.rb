class AddPaidAtColumnToBounty < ActiveRecord::Migration
  def change
    add_column :bounties, :paid_at, :string, :default => nil
  end
end
