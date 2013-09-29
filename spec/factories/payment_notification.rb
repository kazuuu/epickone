FactoryGirl.define do
  factory :payment_notification do
    association :cart
    transaction_id { "asdfg"}
    status { "done" }
    params { "teste" }
  end
end