class StaticController < ApplicationController
  def index
    @repos = Repo.all
    @issues = Issue.all_open_issues
  end
end