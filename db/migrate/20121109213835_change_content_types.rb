class ChangeContentTypes < ActiveRecord::Migration
  def up
    change_column :issues, :body, :text
    change_column :repos, :description, :text
  end

  def down
  end
end
