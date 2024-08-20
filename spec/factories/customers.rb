FactoryBot.define do
    factory :customer do
      name { Faker::Name.first_name }
      surname { Faker::Name.last_name }
      cx_id { Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3) }
    end
  end
