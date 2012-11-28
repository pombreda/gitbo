class RefreshReposWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(repo_id, token)
    repo = Repo.find_by_id(repo_id)

    octokit_client = OctokitWrapper.new(token).client
    octokit_repo = octokit_client.repo("#{repo.owner_name}/#{repo.name}" )
    octokit_issues = octokit_client.list_issues("#{repo.owner_name}/#{repo.name}" )
 
    if repo.updated?(octokit_repo)

      repo.update_repo_attributes(octokit_repo)
      repo.refresh_and_create_issues(octokit_issues, octokit_client)
    end
    repo.save
  end

end




  # from RepoWorker

  # def perform(repo_id, token)  
  #   octokit_client = OctokitWrapper.new(token)
  #   repo = Repo.find_by_id(repo_id)
  #   repo = octokit_client.fetch_repo(repo)
  #   repo = octokit_client.fetch_issues(repo)
  #   repo.save

  #   repo.issues.each do |issue|
  #     issue = octokit_client.fetch_comments(issue)
  #     issue.save
  #   end
  # end


  # From RefreshIssuesWorker

  # def perform(issue_id, token)
    
  #   issue = Issue.find(issue_id)
  #   repo = issue.repo

  #   octokit_client = OctokitWrapper.new(token)
  #   octokit_issue = octokit_client.client.issue("#{issue.repo.owner_name}/#{issue.repo.name}", issue.git_number)
  #   if  octokit_client.client.issue("#{issue.repo.owner_name}/#{issue.repo.name}", issue.git_number, :since => octokit_client.client.last_modified)
  #     issue.update_issue_attributes(octokit_issue)
  #   end
  #   issue.save
  # end