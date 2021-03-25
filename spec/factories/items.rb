FactoryBot.define do
  factory :item do
    name              { Faker::Food.dish }
    introduction      { Faker::Food.description }
    category_id       { Faker::Number.within(range: 2..11) }
    condition_id      { Faker::Number.within(range: 2..7) }
    shipping_payer_id { Faker::Number.within(range: 2..3) }
    shipped_from_id   { Faker::Number.within(range: 2..48) }
    arrive_in_id      { Faker::Number.within(range: 2..4) }
    price             { Faker::Number.within(range: 300..9999999) }
    association :user
  end
end
