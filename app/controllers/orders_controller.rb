class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_public_key, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
    @item = Item.find(params[:item_id])

  end

  def new
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    @item = Item.find(params[:item_id])
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture, :city, :addresses, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 自身のPAY.JPテスト秘密鍵を記述しましょう
      Payjp::Charge.create(
        amount: @item.price,  # 商品の値段
        card: order_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
    end

    def set_public_key
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    end
end