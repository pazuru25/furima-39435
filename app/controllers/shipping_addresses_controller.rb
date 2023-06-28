class ShippingAddressesController < ApplicationController
  before_action :authenticate_user!

  def new
    @shipping_address = ShippingAddress.new
  end

  def create
    @shipping_address = ShippingAddress.new(shipping_address_params)
    if @shipping_address.save
      redirect_to root_path, notice: "Shipping address created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def shipping_address_params
    params.require(:shipping_address).permit(:postal_code, :prefecture, :city, :addresses, :building, :phone_number).merge(user_id: current_user.id)
  end
end