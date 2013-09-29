FactoryGirl.define do
  factory :event do
    title { Faker::Lorem.sentence }
    headline { Faker::Lorem.sentence }
    # prize_title { Faker::Lorem.sentence }
    description  { Faker::Lorem.paragraph }
    instruction  { Faker::Lorem.paragraph } 
    join_min  { 0 }
    join_max { 10 }
    enable { true }
    covering_area { 'pt-br' }
    price_ticket { 10.50 }
    # start_date { '10/10/2013' }
    # end_date { '10/09/2013' }
  end
end