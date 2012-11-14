class Repo < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged
  attr_accessible :description, :name, :open_issues, :owner_name, 
                  :watchers, :issues, :git_updated_at
 
  has_many :issues, :dependent => :destroy

  validates :name, :uniqueness => true

  def self.create_from_github(owner, repo)
    owner, repo = owner.strip, repo.strip
    connection = GithubConnection.new(owner, repo)

    newly_created_repo = Repo.create(:name => connection.name,
                :open_issues => connection.open_issues,
                :owner_name => connection.owner_name,
                :watchers => connection.watchers,
                :git_updated_at => connection.git_updated_at.to_datetime)

    if newly_created_repo.persisted?
      connection.issues.each do |issue|
        Issue.create_from_github(owner, repo, issue.number)
      end
    end
    newly_created_repo
  end

# repo_list = @repos_final.map{|repo| {:name => repo.full_name, :watchers => repo.watchers}} 

  # def self.create_list_repos(keyword)
  #   keyword = "rails"
  #   # name = self.name ||= 0
  #   # watchers = self.watchers ||=0
  #   connection = GithubConnection2.new(keyword)

  #     each_repo = Repo.create(
  #       list.map {:name => connection.name,
  #         :watchers => connection.watchers
  #       })
  #     each_repo
  #   end
  # end

  def popularity
    self.open_issues + self.watchers + self.issues_comment_count
  end
  
  def issues_comment_count
    self.issues.inject(0){|sum, issue| 
      sum + issue.comment_count
    }
  end

end
