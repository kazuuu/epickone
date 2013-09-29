FactoryGirl.define do
  factory :answer do
    question_id { 1 }
    answer_text { 'Resposta 1' }
    description { 'laalala' }
    sort_order { 1 }
    right_answer { false }
    avatar_file_name { 'file.jpg' }
    avatar_content_type { 'jpg' }
    avatar_file_size { 10239 }
    avatar_updated_at { Time.now }
  end
end