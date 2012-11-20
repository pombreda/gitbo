class RefreshReposWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(repo_id)
    repo = Repo.find(repo_id)
    # github_connection = GithubConnection.new(repo.owner_name, repo.name)
    # repo.update_repo_attributes(github_connection) 
    # repo.refresh_and_create_issues(github_connection)
  end

end