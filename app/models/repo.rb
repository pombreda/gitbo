class Repo < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged
  attr_accessible :description, :name, :open_issues, :owner_name, 
                  :watchers, :issues, :git_updated_at
 
  has_many :issues, :dependent => :destroy

  validates :name, :uniqueness => true

  def self.create_from_github(owner, repo)
    owner, repo = owner.strip, repo.strip
    github_connection = GithubConnection.new(owner, repo)

    newly_created_repo = Repo.create(:name => github_connection.name,
                :open_issues => github_connection.open_issues,
                :owner_name => github_connection.owner_name,
                :watchers => github_connection.watchers,
                :git_updated_at => github_connection.git_updated_at)

    if newly_created_repo.persisted?
      github_connection.issues.each do |issue|
        Issue.create_from_github(owner, repo, issue.number)
      end
    end
    newly_created_repo
  end


  def popularity
    self.open_issues + self.watchers + self.issues_comment_count
  end
  
  def issues_comment_count
    self.issues.inject(0){|sum, issue| 
      sum + issue.comment_count
    }
  end

  def updated?(github_connection)
    open_issues_updated?(github_connection) || watchers_updated?(github_connection) || git_updated_at_updated?(github_connection)
  end

  def repo_update_attributes(github_connection)
    self.update_attributes(:open_issues => github_connection.open_issues,
                          :watchers => github_connection.watchers,
                          :git_updated_at => github_connection.git_updated_at)
  end

private

  def open_issues_updated?(github_connection)
    return true unless  github_connection.open_issues == self.open_issues
      
  end

  def watchers_updated?(github_connection)
    return true unless  github_connection.watchers == self.watchers
   
  end

  def git_updated_at_updated?(github_connection)
   return true unless github_connection.git_updated_at == self.git_updated_at
    
  end

end
