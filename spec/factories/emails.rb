# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :email do
    user_id 1
    email "MyString"
    valid_email false
    token "MyString"
  end
end
