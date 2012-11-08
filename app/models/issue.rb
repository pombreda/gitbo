class Issue < ActiveRecord::Base
  attr_accessible :body, :gitnumber, :title, :repo

  belongs_to :repo

end
