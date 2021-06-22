FactoryBot.define do
  factory :post do
    goods_name  { Faker::Lorem.characters(number: 5) }
    caption { Faker::Lorem.characters(number: 20) }
    user
  end
end