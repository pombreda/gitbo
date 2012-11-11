class GithubWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(owner, repo, issue)
     Issue.create_from_github(owner, repo, issue) 
  end

end