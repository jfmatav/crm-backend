FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.first_name }
    role { 0 }
    password { Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3) }
  end
end
