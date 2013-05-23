ActiveAdmin.register Quiz do
  form :html => { :enctype => "multipart/form-data" }  do |f|
    f.inputs "Quizzes", :multipart => true do
      f.input :title
    end
    f.buttons
  end
end