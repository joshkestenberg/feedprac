class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: session_params[:name])
    if user
      session[:user_id] = user.id
      redirect_to user_orders_path(user)
    else
      flash.now[:alert] = "unsuccessful"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:name)
  end
end
