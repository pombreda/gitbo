class RefreshIssuesWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(issue_id, token)

    issue = Issue.find_by_id(issue_id)
    
    repo = issue.repo

    octokit_wrapper = OctokitWrapper.new(token)
    octokit_client = octokit_wrapper.client
    octokit_issue = octokit_client.issue("#{issue.repo_owner}/#{issue.repo_name}", issue.git_number)

    if issue.updated?(octokit_issue)

      issue.update_issue_attributes(octokit_issue)
      issue = octokit_wrapper.fetch_comments(issue)
    end
    issue.save
  end

end


