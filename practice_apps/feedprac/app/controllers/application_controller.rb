class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user(*id)
    if id[0]
      session[:user_id] = id[0]
      User.find(id[0])
    else
      session[:user_id] && User.find(session[:user_id])
    end
  end
end
