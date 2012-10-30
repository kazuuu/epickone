ActiveAdmin.register Cart do
  form do |f|
    f.inputs "Cart", :multipart => true do
      f.input :user_id, :as => :select, :collection => User.all.map {|u| [u.email, u.id]}, :include_blank => false
      f.input :purchased_at
    end
    f.buttons
  end    
end
