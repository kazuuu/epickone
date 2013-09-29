FactoryGirl.define do
  factory :ticket do
    association :cart
    association :event
    origin { "answer" }
    picked_number { rand(100) }
  end
end