class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :title
      t.integer :git_number
      t.string :body

      t.timestamps
    end
  end
end