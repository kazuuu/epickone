FactoryGirl.define do
  factory :category do
    parent_id { 1 }
    title { "" }
    description { "teste" }
    sort_order { 1 }
    avatar_file_name { "filename.jpg" }
    avatar_content_type { "jpg" }
    avatar_file_size { 1000 }
    avatar_updated_at { Time.now }
    join_type { "promo" }
  end
end