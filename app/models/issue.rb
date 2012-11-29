class Issue < ActiveRecord::Base
  attr_accessible :body, :git_number, :title, :repo, :comment_count,
 
  :git_updated_at, :state, :owner_name, :owner_image, :owner_endorsement, :bounties, :difficulty


  belongs_to :repo

  has_many :comments
  has_many :bounties

  validates :git_number, :uniqueness => { :scope => :repo_id } 

  has_many :user_votes
  
  validates :git_number, :uniqueness => { :scope => :repo_id } 


  def bounty_total
    self.bounties.inject(0) {|total = 0, bounty| total += bounty.price } 
  end

  def net_votes
    @net_votes ||= UserVote.where('issue_id = ?', self.id).sum('vote').to_i
  end

  def popularity
    self.popularity_github * self.popularity_gitbo
  end

  def popularity_github
    (self.comment_count*self.repo.popularity)/10
  end

  def popularity_gitbo
    (self.net_votes+1.0)/(self.time_since_submission + 2)**1.5
  end

  def time_since_submission
    (Time.now.to_i - self.git_updated_at.to_i)/86400.0
  end 

  # def add_vote_by(user, direction = :upvote, int = 1)
  #   self.increment(direction, int)
  #   self.user_votes.create(:user => user, direction => 1)
  # end

  def add_vote_by(user, vote)
    uv = UserVote.find_or_create_by_issue_id_and_user_id(self.id, user.id)
    case vote
      when "upvote"
        uv.vote = 1
      when "downvote"
        uv.vote = -1
    end
    uv.save
  end

  def add_difficulty_by(user, rank)
    uv = UserVote.find_or_create_by_issue_id_and_user_id(self.id, user.id)
    uv.update_attribute(:difficulty_rating, rank)
  end

  def retrieve_difficulty(user)
    UserVote.find_or_create_by_issue_id_and_user_id(self.id, user.id).difficulty_rating
  end

  def refresh(github_connection)
    self.update_issue_attributes(github_connection) if self.updated?(github_connection)
  end

  #check if updated_at time on issue in database is same as issue on github
  def updated?(octokit_issue)
    return true unless octokit_issue.updated_at.to_datetime == self.git_updated_at
  end

  def self.all_open_issues
    Issue.all.select do |issue|
      issue.open?
    end
  end

  def open?
    self.state == 'open'
  end

  def update_issue_attributes(octokit_issue)
    self.update_attributes( :body => octokit_issue.body,
                            :title => octokit_issue.title,
                            :comment_count => octokit_issue.comments,
                            :git_updated_at => octokit_issue.updated_at.to_datetime,
                            :state => octokit_issue.state )
  end

  def endorsement_by(approval)
    self.send(approval.to_sym)
  end

  def endorsement
    self.owner_endorsement = 1
  end

  def disapproval
    self.owner_endorsement = -1
  end

  def bounty_claim?

  end


end
