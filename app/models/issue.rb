class Issue < ActiveRecord::Base
  attr_accessible :body, :git_number, :title, :repo, :comment_count,
 
  :git_updated_at, :state, :owner_name, :owner_image, :owner_endorsement, :bounties, :difficulty,

  :avg_difficulty, :vote_count, :repo_name, :repo_owner


  belongs_to :repo

  has_many :comments
  has_many :bounties, :dependent => :destroy

  validates :git_number, :uniqueness => { :scope => :repo_id } 

  has_many :user_votes

  validates :git_number, :uniqueness => { :scope => :repo_id } 

  before_save :write_other_attr

  def self.search_and_filter_open_issues(params)
    includes(:repo, :bounties, :user_votes).
      all_open_issues.
      search(params[:query]).
      filter_by(params[:filters])
  end
  
  def self.filter_by(filter)
    case filter #if params[:filter].present?
      when "hard"
        where("issues.avg_difficulty > 3.9") 
      when "easy"
        where("issues.avg_difficulty <= 3.9" && "issues.avg_difficulty > 0") 
      when "bounty"
        where("issues.bounty_total > 0") 
    end
    # filters.each do |filter|
    # end
  end

  # def self.search(query)
  #   #if params[:query].present? 
  #     where("issues.title LIKE ?", "#{query}%") #sphinx?
  #   #else
  #    # scoped
  #   #end
  # end

  def self.search(search)
    if search
      find(:all, :conditions => ['repo_name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

  def recalculate_bounty_total
    @recalculate_bounty_total ||= self.bounties.inject(0) {|total = 0, bounty| total += bounty.price if bounty.price} 
  end

  def add_bounty(user, price)
    bounty = self.bounties.create(:user_id => user.id, :price => price, :issue_id => self.id)
    self.bounty_total += price.to_i
    self.repo.calc_bounty_total
    self.save
    bounty
  end

  def write_other_attr
    if self.repo
      self.repo_name = self.repo.name
      self.repo_owner = self.repo.owner_name
    end
  end

  def net_votes
    @net_votes ||= Issue.find(self.id).vote_count
  end

  def popularity
    @popualrity ||= (self.popularity_github.to_i.abs + self.net_votes.to_i) # was: (self.popularity_github * self.popularity_gitbo * 10).to_i
  end

  def popularity_github
    @popularity_github ||= (self.comment_count.to_i * self.repo.popularity.to_i)/10  
  end

  def popularity_gitbo
    @popularity_gitbo ||= (self.net_votes.to_i + 1.0)/(self.time_since_submission.to_i + 2)**1.5
  end

  def time_since_submission
    (Time.now.to_i - self.git_updated_at.to_i)/86400.0
  end 

  def vote_tally
    UserVote.where('issue_id = ?', self.id).sum('vote').to_i
  end

  def add_vote_by(user, vote)
    uv = UserVote.find_or_create_by_issue_id_and_user_id(self.id, user.id)
    case vote
      when "upvote"
        uv.vote = 1
      when "downvote"
        uv.vote = -1
    end
    uv.save
    self.vote_count = self.vote_tally
  end

  def add_difficulty_by(user, rank)
    uv = UserVote.find_by_issue_id_and_user_id(self.id, user.id)
    uv.update_attribute(:difficulty_rating, rank)
    self.avg_difficulty = UserVote.user_average_difficulty(self.id)
  end

  def retrieve_difficulty(user)
    UserVote.find_or_create_by_issue_id_and_user_id(self.id, user.id).difficulty_rating
  end

  def refresh(octokie_issue)
    self.update_issue_attributes(octokie_issue) if self.updated?(octokie_issue)
  end

  #check if updated_at time on issue in database is same as issue on github
  def updated?(octokit_issue)
    return true unless octokit_issue.updated_at.to_datetime == self.git_updated_at
  end

  def self.all_open_issues
    Issue.open
  end

  def self.open
    where(:state => 'open')
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

  def how_user_voted(user)
    uv = UserVote.find_or_create_by_issue_id_and_user_id(self.id, user.id)
    case uv.vote
    when 1
      :upvote
    when -1
      :downvote
    when 0
      :no_vote
    end
  end

  def closed?
    #we eventally want to check with Github
    self.state == 'closed'
  end

  def bounty_verification
    true unless self.bounty_total == 0
  end

  def credit_bounties_to(user_id)
    Bounty.find_all_by_issue_id(self.id).each do |bounty|
      bounty.collected_by_user_id = user_id
      bounty.save
    end
  end

end

