FactoryGirl.define do
  factory :constract do
    hotel {Hotel.all.sample}
    customer_id_number {Faker::Code.ean}
    company_name {Faker::Name.name}
    company_phone {Faker::PhoneNumber.phone_number}
    company_address {Faker::Address.street_address}
    check_in_date {Faker::Date.between 10.days.ago, 2.days.ago}
    check_out_date {Faker::Date.between 2.days.ago, Date.today}

    before(:create) do |constract|
      constract.booking_rooms = Random.rand constract.hotel.available_rooms
    end
  end
end

