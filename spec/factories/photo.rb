FactoryGirl.define do
  factory :photo do
    image_type { "jpg"}
    image_file_name { "teste.jpg" }
    image_content_type { "jpg" }
    image_file_size { 1010 }
    image_updated_at { Time.now }
    photable_id { 1 }
    photable_type { "jpg" }
  end
end