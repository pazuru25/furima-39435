class OrderAddress
  include ActiveModel::Model
  attr_accessor :token, :postal_code, :prefecture, :city, :addresses, :building, :phone_number, :item_id, :user_id

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture, numericality: { other_than: 0, message: "can't be blank" }
    validates :city, :addresses, :phone_number
    validates :token
  end

  def save
    order = Order.create(item_id:, user_id:)

    ShippingAddress.create(postal_code:, prefecture:, city:, addresses:,
                           building:, phone_number:, order_id: order.id)
  end
end
