class Issue < ActiveRecord::Base
  attr_accessible :body, :git_number, :title, :repo

  belongs_to :repo


  def self.create_from_github(owner, repo, issue)
    connection = GithubConnection.new(owner, repo, issue)

    Issue.create(:git_number => connection.issue_number,
                  :body => connection.issue_body,
                  :title => connection.issue_title)
  end

end
