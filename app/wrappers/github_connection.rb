class GithubConnection

  attr_accessor :repo, :info, :issue_no, :client, :issues, :name

  def initialize(owner, repo, issue_no = nil)
    @client = Octokit::Client.new(:login => "flatiron-dummy", :password => "flatiron2012")
    @repo = "#{owner}/#{repo}"
    @info = @client.repo(@repo)
    @issue_no = issue_no
    @issues = @client.list_issues(@repo)
  end

  def self.repo_params(*args)
    args.each do |arg|
      define_method arg.to_sym do
        self.info.send(arg)
      end
    end
  end
    repo_params :name, :open_issues, :watchers

  def git_updated_at
    self.info.updated_at
  end

  def owner_name
    self.info.owner.login
  end

  def self.issue_params(*args)
    args.each do |arg|
      define_method ("issue_#{arg}").to_sym do
        self.client.issue(self.repo, self.issue_no).send(arg)
      end
    end
  end
    issue_params :comments, :title, :body, :number

  def issue_git_updated_at
    issue = self.client.issue(self.repo, self.issue_no).
    send(:updated_at)
  end
  
end

