class RepoWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(repo, token = nil)  
    octokit_client = OctokitWrapper.new(token)
    # puts repo_id.inspect
    repo = Repo.find_by_id(repo_id)
    # puts repo.inspect
    octokit_client.fetch_repo(repo)
    octokit_client.fetch_issues(repo)
    
    repo.issues.each do |issue|
      issue = octokit_client.fetch_comments(issue)
      issue.save
    end

    # SubscribeToPubsubWorker.perform_async(repo, current_user.token)
    hook_url = "http://requestb.in/1gmjod91" 
    # this will be the callback it the future "http://coil.io/hook/#{project.key}"

    @client.subscribe(
      "https://github.com/flatiron-school/gitbo/events/push",
      hook_url)

    puts 'you subscribed'
  end

end 
