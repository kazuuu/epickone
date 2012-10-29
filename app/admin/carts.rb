ActiveAdmin.register Cart do
  form do |f|
    f.inputs "Drawship", :multipart => true do
      f.input :draw_id
      f.input :user_id, :as => :select, :collection => User.all.map {|u| [u.email, u.id]}, :include_blank => false
    end
    f.buttons
  end    
end
