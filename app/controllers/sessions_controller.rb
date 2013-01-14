class SessionsController < ApplicationController
  
  def new
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    session[:token] = auth.credentials.token
    
    user.token = auth.credentials.token
    user.save
    user.load_cache_info

    redirect_to request.env['omniauth.origin'] || root_path
  end

  def destroy
    session[:user_id] = nil
    session[:token] = nil
    redirect_to :root
  end

  def failure
    flash[:error] = "There was a problem authenticating with Github. Github says: #{ params[:message] }.\n #{ request.env["omniauth.auth" ]}"
    redirect_to :root
  end

end