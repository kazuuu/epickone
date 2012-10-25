ActiveAdmin.register Draw do
  form do |f|
    f.inputs "Draws", :multipart => true do
      f.input :avatar
      f.input :title
      f.input :min_users
      f.input :max_users
      f.input :localization
      f.input :price
      f.input :date_due
      f.input :date_start
      f.input :description
      f.input :user_id, :as => :select, :collection => User.all.map {|u| [u.email, u.id]}, :include_blank => false
    end
    f.buttons
  end  
end

