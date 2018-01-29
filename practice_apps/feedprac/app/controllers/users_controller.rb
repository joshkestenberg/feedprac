class UsersController < ApplicationController
  before_action :check_user, only: [:new]

  def new
    @user = User.new
  end

  def create
    new_params = User.find_driver_admin_id(user_params)

    @user = User.new(new_params)

    if @user.save
      current_user(@user.id)
      flash[:notice] = "success"
      redirect_to user_orders_path(current_user)
    else
      flash.now[:alert] = @user.errors.full_messages
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    new_params = User.find_driver_admin_id(user_params)

    @user = User.find(params[:id])
    if @user == current_user && @user.update_attributes(new_params)
      flash[:notice] = "success"
      redirect_to user_orders_path(current_user)
    else
      flash.now[:alert] = @user.errors.full_messages
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :role, :driver_admin)
  end

  def check_user
    if current_user
      redirect_to user_orders_path(current_user)
    end
  end
end
