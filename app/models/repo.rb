class Repo < ActiveRecord::Base
  attr_accessible :description, :name, :open_issues, :owner_name, :watchers
end
