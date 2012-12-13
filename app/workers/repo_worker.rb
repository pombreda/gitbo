class RepoWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(repo_id, token = nil)  
    octokit_client = OctokitWrapper.new(token)
    # puts repo_id.inspect
    repo = Repo.find_by_id(repo_id)
    # puts repo.inspect
    repo = octokit_client.fetch_repo(repo)
    repo = octokit_client.fetch_issues(repo)
    repo.issues.each do |issue|
      issue = octokit_client.fetch_comments(issue)
      issue.save
    end
  end

end 
