ActiveAdmin.register Cartitem do
  form :html => { :enctype => "multipart/form-data" }  do |f|
    f.inputs "Draws", :multipart => true do
      f.input :draw_id
      f.input :cart_id
      f.input :unit_price
      f.input :quantity
      f.input :comment
      f.input :picked_number
#      f.input :user_id, :as => :select, :collection => User.all.map {|u| [u.email, u.id]}, :include_blank => false
    end
    f.buttons
  end
end