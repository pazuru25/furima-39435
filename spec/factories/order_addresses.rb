FactoryBot.define do
  factory :order_address do
    postal_code    { '123-4567' }
    prefecture     { 1 }
    city           { '千代田区' }
    addresses      { '1-1' }
    building       { 'ハイツ' }
    phone_number   { '09011112222' }
    token          { 'tok_abcdefghijk00000000000000000' }
  end
end
