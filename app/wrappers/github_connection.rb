class GithubConnection

  attr_accessor :repo, :info, :issue_no, :client, :issues

  def initialize(owner, repo, issue_no = nil)
    @client = Octokit::Client.new(:login => "flatiron-dummy", :password => "flatiron2012")
    @repo = "#{owner}/#{repo}"
    @info = @client.repo(@repo)
    @issue_no = issue_no
    @issues = @client.list_issues(@repo)
  end

  def url
    self.info.html_url
  end

  def name
    self.info.name
  end

  def owner_name
    self.info.owner.login
  end

  def open_issues
    self.info.open_issues
  end

  def watchers
    self.info.watchers
  end

  def issue_title
    self.client.issue(self.repo, self.issue_no).title
  end

  def issue_body
    self.client.issue(self.repo, self.issue_no).body
  end

  def issue_number
    self.client.issue(self.repo, self.issue_no).number
  end


end

