class AddOwnerToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :owner_name, :string
    add_column :issues, :owner_image, :string
  end
end
