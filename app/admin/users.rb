ActiveAdmin.register User do
  form do |f|
    f.inputs "Users", :multipart => true do
          f.input :avatar, :as => :file, :multipart => true, :label => "Avatar", :hint => f.object.avatar.nil? ? 
            f.template.content_tag(:span, "No Image Yet") : 
            f.template.image_tag(f.object.avatar.url(:thumb)) 
            f.input :avatar_delete, :as=>:boolean, :required => false, :label => 'Remove image' 
          f.input :email
          f.input :first_name
          f.input :last_name
          f.input :document
          f.input :title
          f.input :gender
          f.input :birthday
          f.input :city
          f.input :state
          f.input :country
          f.input :address1
          f.input :address2
          f.input :zipcode
          f.input :phone_mobile
          f.input :admin_flag
          f.input :password
          f.input :facebook_uid
          f.input :twitter_uid
        end
        f.buttons
      end    
end
