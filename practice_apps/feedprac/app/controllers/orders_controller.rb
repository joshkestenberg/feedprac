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

    unless Order.can_edit?(@user, @order)
      flash[:alert] = "you're unauthorized to edit the order at this time"
      redirect_to user_orders_path(@user, @order)
    end
  end

  def update
    @user = User.find(params[:user_id])
    @order = Order.find(params[:id])

    if @order.update_attributes(order_params)
      if @user.role != "business" && @user.role != "admin"
        Order.assign(@order, @user, order_params)
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

    if (@user.role == "business" && @order.ready_claim == true) || user.role == "admin"
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

    if @order.awaiting_pick
      @order.picked_up = Time.current
      @order.awaiting_pick = false
      @order.transit = true
      @order.save
    elsif @order.transit
      @order.dropped_off = Time.current
      @order.transit = false
      @order.complete = true
      @order.save
    end

    redirect_to user_orders_path(@user, @order)
  end

  def approve
    @user = User.find(params[:user_id])
    @order = Order.find(params[:id])

    @order.ready_pick = true
    @order.awaiting_approval = false
    @order.save

    redirect_to user_orders_path(@user, @order)
  end

  def deny
    @user = User.find(params[:user_id])
    @order = Order.find(params[:id])

    charity = @order.users.find_by(role: "charity")
    charity.orders.delete(@order)

    @order.claim_time = nil
    @order.ready_claim = true
    @order.awaiting_approval = false
    @order.save

    redirect_to user_orders_path(@user, @order)
  end

  private

  def order_params
    params.require(:order).permit(:pickup_start, :pickup_end, :dropoff_end, :dropped_off, :ready_claim, :ready_pick, :transit, :complete, :claim_time, :picked_up, :awaiting_pick, :driver_name, :driver_admin_name, :awaiting_approval)
  end
end
