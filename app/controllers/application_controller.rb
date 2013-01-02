class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from Octokit::BadGateway, :with => :github_error
  helper_method :current_user, :octokit_client, :sort_alphabetically


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def octokit_client
    if current_user && current_user.token
      @octokit_client ||= OctokitWrapper.new(current_user.token)
    else
      @octokit_client ||= OctokitWrapper.new #uses our client id and secret
    end
  end

  def github_error
    flash[:error] = "There was a problem communicating with Github"
    redirect_to :back
  end


  # def login_require
  #   unless current_user
  #     redirect_to login_path, :notice => "please login"


  # def current_user
  #   @current_user ||= User.find_by_id{session[:user_id])
  # end

  # helper_method :current_user
  #   #copies them to Hellpercontroller for user with views

  def logged_in?
    true if current_user
  end
end
