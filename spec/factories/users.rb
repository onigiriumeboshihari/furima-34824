FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    last_name             {'名字'}
    first_name            {'名前'}
    last_kana             {'ミョウジ'}
    first_kana            {'ナマエ'}
    birthday              {'1930-01-01'}
  end
end
