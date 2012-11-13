class AddSlugToRepos < ActiveRecord::Migration
  def change
    add_column :repos, :slug, :string
    add_index :repos, :slug
  end
end
