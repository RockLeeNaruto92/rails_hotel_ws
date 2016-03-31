FactoryGirl.define do
  factory :hotel do
    code {Faker::Code.isbn}
    name {Faker::Name.title}
    star {Random.rand 5}
    city {Faker::Address.city}
    country {Faker::Address.country}
    address {Faker::Address.street_address}
    website {Faker::Internet.url}
    phone {Faker::PhoneNumber.phone_number}
    total_rooms {Faker::Number.number 2}
    cost {Faker::Number.number 3}
  end
end
