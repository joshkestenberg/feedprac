class OrdersController < ApplicationController
  def index
    @user = User.find(params[:user_id])

    @all_orders = Order.all
    @user_orders = @user.orders

  end

  def new
    @user = User.find(params[:user_id])
    @order = Order.new
  end

  def create
    @user = User.find(params[:user_id])
    @order = Order.new(order_params)

    if @order.save
      if @user.role != "admin"
        @user.orders << @order
      else
        User.find_by(name: order_params[:business_name]).orders << @order
      end
      flash[:notice] = "success"
      redirect_to user_orders_path
    else
      flash.now[:alert] = @order.errors.full_messages
      render :new
    end

  end

  def edit
    @user = User.find(params[:user_id])
    @order = Order.find(params[:id])

    unless @order.can_edit?(@user)
      flash[:alert] = "you're unauthorized to edit the order at this time"
      redirect_to user_orders_path(@user, @order)
    end
  end

  def update
    @user = User.find(params[:user_id])
    @order = Order.find(params[:id])

    if @order.update_attributes(order_params)
      if @user.role != "business" && @user.role != "admin"
        @order.assign(@user, order_params)
      end

      redirect_to user_orders_path(@user, @order)
    else
      flash.now[:alert] = @order.errors.full_messages
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @order = Order.find(params[:id])

    if (@user.role == "business" && @order.status == "available") || @user.role == "admin"
      @order.destroy
      redirect_to user_orders_path(@user, @order)
    else
      flash[:alert] = "you're unauthorized to delete this order"
      redirect_to user_orders_path(@user, @order)
    end
  end

  def pickdrop
    @user = User.find(params[:user_id])
    @order = Order.find(params[:id])

    if @order.status == "awaiting pickup"
      @order.picked_up = Time.current
      @order.status = "in transit"
      @order.save
    elsif @order.status == "in transit"
      @order.dropped_off = Time.current
      @order.status = "complete"
      @order.save
    end

    redirect_to user_orders_path(@user, @order)
  end

  def approve
    @user = User.find(params[:user_id])
    @order = Order.find(params[:id])

    @order.status = "seeking driver"
    @order.save

    redirect_to user_orders_path(@user, @order)
  end

  def deny
    @user = User.find(params[:user_id])
    @order = Order.find(params[:id])

    charity = @order.users.find_by(role: "charity")
    charity.orders.delete(@order)

    @order.claim_time = nil
    @order.status = "available"
    @order.save

    redirect_to user_orders_path(@user, @order)
  end

  private

  def order_params
    params.require(:order).permit(:pickup_start, :pickup_end, :dropoff_end, :dropped_off, :claim_time, :picked_up, :driver_name, :driver_admin_name, :charity_name, :business_name, :status)
  end
end
