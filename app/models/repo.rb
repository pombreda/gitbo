class Repo < ActiveRecord::Base
  attr_accessible :description, :name, :open_issues, :owner_name, :watchers, :issues
 
  has_many :issues, :dependent => :destroy

  validates :name, :uniqueness => true

  def self.create_from_github(owner, repo)
    owner, repo = owner.strip, repo.strip
    connection = GithubConnection.new(owner, repo)

    newly_created_repo = Repo.create(:name => connection.name,
                :open_issues => connection.open_issues,
                :owner_name => connection.owner_name,
                :watchers => connection.watchers)

    if newly_created_repo.persisted?
      connection.issues.each do |issue|
        Issue.create_from_github(owner, repo, issue.number)
      end
    end
    newly_created_repo
  end

end