class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string :name
      t.string :owner_name
      t.string :description
      t.integer :watchers
      t.integer :open_issues

      t.timestamps
    end
  end
end