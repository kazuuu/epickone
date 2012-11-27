ActiveAdmin.register Credit do
  form :html => { :enctype => "multipart/form-data" }  do |f|
    f.inputs "Credits", :multipart => true do
      f.input :user_id, :as => :select, :collection => User.all.map {|u| [u.email, u.id]}, :include_blank => false
      f.input :draw_id, :as => :select, :collection => Draw.all.map {|u| [u.title, u.id]}, :include_blank => false
      f.input :value
      f.input :credit_type
      f.input :comment
      f.input :is_used
      f.input :used_at
    end 
    f.buttons
  end
end
