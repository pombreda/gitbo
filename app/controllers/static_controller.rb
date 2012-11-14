class StaticController < ApplicationController
  def index
    @repos = Repo.all
  end
end