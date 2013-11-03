ActiveAdmin.register Ticket do
  form :html => { :enctype => "multipart/form-data" }  do |f|
    f.inputs "Events", :multipart => true do
      f.input :user_id, :as => :select, :collection => User.all.map {|u| [u.email, u.id]}, :include_blank => false
      f.input :origin
      f.input :picked_number
      f.input :submitted_at
      f.input :event_id, :as => :select, :collection => Event.all.map {|u| [u.title, u.id]}, :include_blank => false
    end
    f.buttons
  end
end