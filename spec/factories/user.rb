FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    first_name  { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    mobile_phone_number {  Faker::PhoneNumber.phone_number }
    document { Faker::PhoneNumberAU.phone_number }
    gender { 'Male' }
    birthday { '10/10/1980' }
    city_id { 1 }
    state_id { 1 }
    country_id { 1 }
    address1 { Faker::AddressAU.street_address }
    address2 { Faker::AddressAU.street_address }
    postcode { Faker::AddressAU.postcode }
  end

end