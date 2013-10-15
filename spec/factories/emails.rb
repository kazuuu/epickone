# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :email do
    user_id 1
    email "MyString@teste.com.br"
    valid_email false
    token "MyString"
  end
end
