class UserVote < ActiveRecord::Base
  attr_accessible :downvote, :issue_id, :upvote, :user_id, :user, :difficulty_rating
  
  belongs_to :user
  belongs_to :issue

  validates_uniqueness_of :issue_id, :scope => :user_id

  def self.user_average_difficulty(issue_id)
    all_issues = UserVote.find_all_by_issue_id(256)
    all_issues = all_issues.select { |issue| issue.difficulty_rating != 0 }
    total = all_issues.inject(0) { |sum, iss| sum + iss.difficulty_rating }
    average = total / all_issues.count.to_f
    average.round(1)
  end

  def self.repo_owner_id(issue)
    owner = User.find_by_nickname(issue.repo.owner_name)
    owner.id if owner
  end

  def self.owner_record(issue)
    self.find_by_issue_id_and_user_id(issue.id, self.repo_owner_id(issue))
  end

  def self.owner_rating(issue)
    self.owner_record(issue).difficulty_rating
  end

  def self.owner_difficulty_rating?(issue)
    return false if self.repo_owner_id(issue) == nil
    return true if self.owner_rating(issue)
  end

end

