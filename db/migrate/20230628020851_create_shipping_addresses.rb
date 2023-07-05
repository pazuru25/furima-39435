class CreateShippingAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_addresses do |t|
      t.string      :postal_code,         null: false
      t.integer     :prefecture,          null: false
      t.text        :city,                null: false
      t.text        :addresses,           null: false
      t.text        :building
      t.string      :phone_number,        null: false
      t.references  :order,               null: false, foreign_key: true
      t.timestamps
    end
  end
end
