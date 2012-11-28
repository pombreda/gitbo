class RefreshReposWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(repo_id, token)
    repo = Repo.find_by_id(repo_id)

    octokit_wrapper = OctokitWrapper.new(token)
    octokit_client = octokit_wrapper.client
    octokit_repo = octokit_client.repo("#{repo.owner_name}/#{repo.name}" )
    octokit_issues = octokit_client.list_issues("#{repo.owner_name}/#{repo.name}" )

    if repo.updated?(octokit_repo)

      repo.update_repo_attributes(octokit_repo)
      repo.refresh_and_create_issues(octokit_issues, octokit_client)

      repo.issues.each do |issue|
        issue = octokit_wrapper.fetch_comments(issue)
        issue.save
      end
    end
    repo.save
  end

end
