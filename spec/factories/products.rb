FactoryBot.define do
  factory :product do
    name { Faker::Name.name }
    list_price { Faker::Number.between(from: 1, to: 10) }
    sell_price { Faker::Number.between(from: 1, to: 10) }
    on_sell { false }
    vendor
    category
  end
end
