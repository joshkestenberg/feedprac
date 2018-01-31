class Order < ApplicationRecord
  has_and_belongs_to_many :users

  validate :pickup_start_valid?, :on => :create
  validate :pickup_end_valid?, :dropoff_end_valid?

  attr_accessor :driver_name, :driver_admin_name, :charity_name, :business_name

  def can_edit?(user)
    if (user.role == "business" || user.role == "charity") && self.status != "available"
      false
    elsif (user.role == "driver" || user.role == "driver admin") && self.status != "seeking driver"
      false
    else
      true
    end
  end

  def assign(user, order_params)
    if user.role == "charity"
      user.orders << self
    elsif user.role == "driver admin"
      user.orders << self
      User.find_by(name: order_params[:driver_name]).orders << self
    elsif user.role == "driver"
      user.orders << self
      User.find_by(driver_admin_id: user.id).orders << self if User.where(driver_admin_id: user.id).exists?
    else
      User.find_by(name: order_params[:driver_name]).orders << self if order_params[:driver_name] != ""
      User.find_by(name: order_params[:driver_admin_name]).orders << self if order_params[:driver_admin_name] != ""
      User.find_by(name: order_params[:business_name]).orders << self if order_params[:business_name] != ""
      User.find_by(name: order_params[:charity_name]).orders << self if order_params[:charity_name] != ""
    end
  end

  def pickup_start_valid?
    if self.pickup_start < Time.current - 1.minute
      errors.add(:pickup_start, 'must be later than current time')
    end
  end

  def pickup_end_valid?
    if self.pickup_end < self.pickup_start + 30.minutes
      throw
      errors.add(:pickup_end, 'must leave at least a 30 minute window for pickup')
    end
  end

  def dropoff_end_valid?
    if self.dropoff_end != nil && self.dropoff_end < self.pickup_end  + 30.minutes
      errors.add(:dropoff_end, 'must be at least 30 minutes after end of pickup window')
    end
  end


end
