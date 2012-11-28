class RefreshIssuesWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(issue_id, token)

    issue = Issue.find_by_id(issue_id)
    repo = issue.repo

    octokit_client = OctokitWrapper.new(token).client
    octokit_issue = octokit_client.issue("#{issue.repo.owner_name}/#{issue.repo.name}", issue.git_number)

    if issue.updated?(octokit_issue)
      issue.update_issue_attributes(octokit_repo)
    end
    issue
  end

end


