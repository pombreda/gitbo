class Issue < ActiveRecord::Base
  attr_accessible :body, :git_number, :title, :repo, :comment_count, :git_updated_at

  belongs_to :repo

  validates :git_number, :uniqueness => { :scope => :repo_id } 

  def self.create_from_github(owner, repo, issue)
    connection = GithubConnection.new(owner, repo, issue)

    Issue.new(:git_number => connection.issue_number,
                  :body => connection.issue_body,
                  :title => connection.issue_title,
                  :comment_count => connection.issue_comments,
                  :git_updated_at => connection.issue_git_updated_at.to_datetime
                  ).tap do |i|
      i.repo = Repo.find_or_create_by_name("#{repo}")
      i.save
    end
  end

  def popularity
    upvote = self.upvote ||= 0
    downvote = self.downvote ||= 0
    self.comment_count + upvote - downvote
  end

  def add_upvote(int = 1)
    self.increment(:upvote, int)
  end

  def add_downvote(int = 1)
    self.increment(:downvote, int)
  end

end
