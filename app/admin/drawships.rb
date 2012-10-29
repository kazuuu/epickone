ActiveAdmin.register Drawship do
  form do |f|
    f.inputs "Drawship", :multipart => true do
      f.input :draw_id
      f.input :cart_id
      f.input :user_id, :as => :select, :collection => User.all.map {|u| [u.email, u.id]}, :include_blank => false
      f.input :picked_number
    end
    f.buttons
  end    

  
  show :id => :id do |drawship|
    attributes_table do
      row :id
      row :draw_id
      row :user_id 
      row :cart_id
      row :picked_number
    end
  end
end