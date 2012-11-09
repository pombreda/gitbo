class Issue < ActiveRecord::Base

  attr_accessible :body, :git_number, 
                  :title, :repo, :repo_name,
                  :repo_id

  belongs_to :repo

  # def initialize
  #    @issue = self
  # end

  # def build_repo_id(repo_name)
  #   self.repo_id = 
  # end

  def self.create_from_github(owner, repo, issue)
    connection = GithubConnection.new(owner, repo, issue)

    issue = Issue.create(:git_number => connection.issue_number,
                  :body => connection.issue_body,
                  :title => connection.issue_title,
                  :repo_name => repo,
                  )
    issue.repo_id = Repo.find_or_create_by_name("#{repo}").id
    issue.save
    issue
  end

  


<<<<<<< HEAD
end
=======
end
>>>>>>> 587edb7e96008ca47452c1a3b91dd55c748443bb
