class OctokitWrapper

  attr_accessor :client

  def initialize(token = nil)
    if token
      @client = Octokit::Client.new(:oauth_token => token)
    else
      @client = Octokit::Client.new(:client_id => CONFIG[:github_client_id], :client_secret => CONFIG[:github_client_secret])
    end
  end

  #expects repo with owner_name and name
  #returns fully populated repo
  def fetch_repo(repo)
    info = client.repo(repo.octokit_id)
    repo.update_attributes( :open_issues => info.open_issues,
                            :owner_name => info.owner.login,
                            :watchers => info.watchers,
                            :git_updated_at => info.updated_at.to_datetime )
    repo.save
    repo
  end  

  def fetch_issues(repo)
    issues = client.list_issues(repo.octokit_id)
    issues.each do |issue|
      repo.issues.build(
        :git_number => issue.number,
        :body => issue.body,
        :title => issue.title,
        :comment_count => issue.comments,
        :git_updated_at => issue.updated_at.to_datetime,
        :state => issue.state,
        :owner_name => issue.user.login,
        :owner_image => issue.user.avatar_url
       )
    end
    repo
  end

  def fetch_comments(issue)
    comments = client.issue_comments(issue.repo.octokit_id, issue.git_number)
    comments.each do |comment|
      unless issue.comments.find_by_git_number(comment.id)
        issue.comments.build(
          :body => comment.body,
          :git_update_at => comment.updated_at.to_datetime,
          :git_number => comment.id,
          :owner_name => comment.user.login,
          :owner_image => comment.user.avatar_url
        )
      end
    end
    issue
  end

  def post_comment(comment)
    client.add_comment(comment.repo, comment.issue.git_number, comment.body)
  end

  def update_issue_attributes(issue)
    issue.update_attributes( :body => issue.body,
                            :title => issue.title,
                            :comment_count => issue.comments,
                            :git_updated_at => issue.git_updated_at,
                            :state => issue.state )
  end

  def check_existence_of(user) # user.nickname.should not_be nil
    if cache_knows_whether_user_exists_on_github?(user)
      user_exists_on_github?(user)
    else
      check_existence_on_github_and_write_to_cache(user)
    end
    # TODO: write this method and refactor into repo.rb
    # change into conditional request
    # Can this be polymorphic, accepting repo/user/issue objects?
  end

  private

    def cache_knows_whether_user_exists_on_github?(user)
      !Rails.cache.read(user.nickname.to_sym)[:exists?].nil? if Rails.cache.read(user.nickname.to_sym)
    end

    def user_exists_on_github?(user)
      response_from_cache = Rails.cache.read(user.nickname.to_sym)[:exists?] 
      if response_from_cache
        return true
      else
        return false
      end
    end

    def check_existence_on_github_and_write_to_cache(user)
      begin
          client.user(user.nickname)
      rescue Octokit::NotFound, URI::InvalidURIError
        Rails.cache.fetch(user.nickname.to_sym, expires_in: 24.hours) do
          { :exists? => false  }
        end
        return false
      end
      return true
    end

end
