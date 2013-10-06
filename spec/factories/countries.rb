# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :country do
    name "MyString"
    iso2 "MyString"
    iso3 "MyString"
    phone_code 1
    locale "MyString"
  end
end
