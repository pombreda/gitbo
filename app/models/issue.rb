class Issue < ActiveRecord::Base
  attr_accessible :body, :gitnumber, :title
end
