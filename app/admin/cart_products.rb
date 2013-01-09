ActiveAdmin.register CartProduct do
  form :html => { :enctype => "multipart/form-data" }  do |f|
    f.inputs "Events", :multipart => true do
      f.input :cart_id
      f.input :product_id, :as => :select, :collection => Product.all.map {|u| [u.title, u.id]}, :include_blank => false
      f.input :user_id, :as => :select, :collection => User.all.map {|u| [u.email, u.id]}, :include_blank => false
      f.input :unit_price
      f.input :quantity
      f.input :comment
    end
    f.buttons
  end
end