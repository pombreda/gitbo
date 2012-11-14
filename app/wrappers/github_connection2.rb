class GithubConnection2

  attr_accessor :repo, :info, :issue_no, :client, :issues, :name

  def initialize(keyword)
    @client = Octokit::Client.new(:login => "flatiron-dummy", :password => "flatiron2012")
    @keyword = "rails"
    # @info = @client.keyword(@keyword)
    @repos = @client.list_repos(@keyword).sort_by{|e| e[:watchers]}.reverse[1..10]
  end

  def create_list
    # @repos_final.map{|repo| {:name => repo.full_name, :watchers => repo.watchers}}
    list = @client.map {|repo| {:name => repo.full_name, :watchers => repo.watchers }}
  end


  # def self.repo_params(*args)
  #   args.each do |arg|
  #     define_method arg.to_sym do
  #       self.info.send(arg)
  #     end
  #   end
  # end
  #   repo_params :name, :open_issues, :watchers

  # def git_updated_at
  #   self.info.updated_at
  # end

  # def owner_name
  #   self.info.owner.login
  # end

  # def self.issue_params(*args)
  #   args.each do |arg|
  #     define_method ("issue_#{arg}").to_sym do
  #       self.client.issue(self.repo, self.issue_no).send(arg)
  #     end
  #   end
  # end
  #   issue_params :comments, :title, :body, :number

  # def issue_git_updated_at
  #   issue = self.client.issue(self.repo, self.issue_no).
  #   send(:updated_at)
  # end
  
end

