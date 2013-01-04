class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :image, :nickname

  has_many :user_votes
  has_many :bounties

  def self.create_with_omniauth(auth)
  create! do |user|
    user.provider = auth["provider"]
    user.uid = auth["uid"]
    user.name = auth["info"]["name"]
    user.nickname = auth["info"]["nickname"]
    user.email = auth["info"]["email"]
    user.image = auth["info"]["image"]
    end
  end

  def voted_on?(issue)
    @votes ||= self.user_votes
    this_vote = @votes.detect{|uv| uv.issue_id == issue.id}
    if this_vote
      case this_vote.vote
        when 1
          :upvote
        when -1
          :downvote
      end
    else  
      :no_vote
    end
  end

  def session_token
    session[:token]
  end
  
  def load_cache_info
    client = Octokit::Client.new(:oauth_token => self.token)
    Rails.cache.fetch(self.nickname.to_sym, expires_in: 24.hours) do
      { :repos => client.repositories(self.nickname).collect {|repo| repo.name },
        :following => client.following(self.nickname).collect {|user| user.login },
        :starred => client.starred(self.nickname).collect {|repo| "#{repo.owner.login}/#{repo.name}" }  }
    end
  end

  def self.is_the_owner_registered?(owner)
    User.find_by_nickname(owner)
  end

  def cache
    Rails.cache.read(self.nickname.to_sym) || load_cache_info
  end

  def cached_starred
    cache[:starred].collect do |repo_string|
      owner_name, name = repo_string.split('/')
      {:owner_name => owner_name, :name => name}
    end
  end

  def cached_following
    cache[:following]
  end

  def cached_repos
    cache[:repos]
  end

  def repos_not_on_gitbo
    cache[:repos].select do |repo_name|
      true unless Repo.find_by_owner_name_and_name(self.nickname, repo_name)
    end
  end

  def bounty_total
    @bounty ||= self.bounties.inject(0) {|total = 0, bounty| total += bounty.price } 
  end

  def bounty_collected
    @bounties ||= Bounty.where('collected_by_user_id = ?', self.id)
  end

  def total_bounties_collected
    @bounties ||= Bounty.where('collected_by_user_id = ?', self.id).sum('price').to_i
  end

  def check_bounty_winner(repo_url, issue)
    client = OctokitWrapper.new(self.token).client
    octokit_events = client.issue_events(repo_url, issue.git_number)
    event = octokit_events.find { |e| e.event == "closed"}
    event ? get_commit_author(repo_url, event, client) : false
  end

  private
  def get_commit_author(repo_url, event, client)
    commit = client.commit(repo_url, event.commit_id)
    bounty_winner = commit.author.login
    true if self.nickname == bounty_winner
  end
end
