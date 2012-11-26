class UserVote < ActiveRecord::Base
  attr_accessible :downvote, :issue_id, :upvote, :user_id, :user, :difficulty_rating
  
  belongs_to :user
  belongs_to :issue

  validates_uniqueness_of :issue_id, :scope => :user_id

end
