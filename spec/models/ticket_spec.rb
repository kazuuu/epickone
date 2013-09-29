FactoryGirl.define do
  factory :ticket do
    association :cart
  end
end