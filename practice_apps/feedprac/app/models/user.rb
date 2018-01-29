class User < ApplicationRecord
  validates :name, uniqueness: true
  validate :check_admin_id

  has_and_belongs_to_many :orders

  attr_accessor :driver_admin

  def self.find_driver_admin_id(user_params)
    if user_params[:driver_admin] != "" && User.where(name: user_params[:driver_admin]).exists?
      user_params[:driver_admin_id] = User.find_by(name: user_params[:driver_admin]).id
      user_params.delete(:driver_admin)
    end
    return user_params
  end

  def check_admin_id
    if self.role != "driver" && self.driver_admin_id
      errors.add(:driver_admin_id, 'cannot be present if role is not driver')
    elsif self.role == "driver" && !driver_admin_id == nil && !User.where(id: driver_admin_id).exists?
      errors.add(:driver_admin_id, "driver admin doesn't exist")
    end
  end
end
