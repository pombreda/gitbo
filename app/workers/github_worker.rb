class GithubWorker
  include Sidekiq::Worker

  def perform(owner, repo, issue_no = nil)
    
  end

end