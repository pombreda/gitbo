class RefreshIssuesWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(issue_id, token)

   

    issue = Issue.find(issue_id)
    repo = issue.repo

    octokit_client = OctokitWrapper.new(token)
    octokit_issue = octokit_client.client.issue("#{issue.repo.owner_name}/#{issue.repo.name}", issue.git_number)
    if  octokit_client.client.issue("#{issue.repo.owner_name}/#{issue.repo.name}", issue.git_number, :since => octokit_client.client.last_modified)
      issue.update_issue_attributes(octokit_issue)
    end
    issue.save
  end

end


