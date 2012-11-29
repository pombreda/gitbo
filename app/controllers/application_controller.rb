class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :octokit_client, :sort_alphabetically


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def octokit_client
    # if current_user.has_github_token?
      @octokit_client ||= OctokitWrapper.new(current_user.token)
    # else
      # TODO: use our app ID and secret to make calls
    # end
  end


  # def login_require
  #   unless current_user
  #     redirect_to login_path, :notice => "please login"
  # end

  # def current_user
  #   @current_user ||= User.find_by_id{session[:user_id])
  # end

  # helper_method :current_user
  #   #copies them to Hellpercontroller for user with views

  # def logged_in?
  #   true if current_user
  # end
end
