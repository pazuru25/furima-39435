class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture, :city, :addresses, :building, :phone_number, :token, :item_id, :user_id

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture, numericality: { other_than: 0, message: "can't be blank" }
    validates :phone_number, length: { minimum: 10, maximum: 11 }, format: { with: /\A\d+\z/ }
    validates :city, :addresses, :token, :user_id, :item_id
  end

  def save
    order = Order.create(item_id:, user_id:)

    ShippingAddress.create(postal_code:, prefecture:, city:, addresses:,
                           building:, phone_number:, order_id: order.id)
  end
end
