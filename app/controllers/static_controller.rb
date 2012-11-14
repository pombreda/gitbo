class StaticController < ApplicationController
  def index
    @repos = Repo.all
    @issues = Issue.all
  end
end