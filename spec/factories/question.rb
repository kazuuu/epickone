FactoryGirl.define do
  factory :question do
    quiz_id { 1 }
    title { 'O que é ' }
    description { 'laalala' }
    sort_order { 1 }
    style { 'video' }
    question_type { 'test' }
    avatar_file_name { 'file.jpg' }
    avatar_content_type { 'jpg' }
    avatar_file_size { 10239 }
    avatar_updated_at { Time.now }
  end
end