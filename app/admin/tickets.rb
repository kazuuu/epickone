ActiveAdmin.register Ticket do
  form :html => { :enctype => "multipart/form-data" }  do |f|
    f.inputs "Events", :multipart => true do
      f.input :cart_id
      f.input :unit_price
      f.input :quantity
      f.input :comment
      f.input :picked_number
      f.input :event_id, :as => :select, :collection => Event.all.map {|u| [u.title, u.id]}, :include_blank => false
    end
    f.buttons
  end
end