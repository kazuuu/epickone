ActiveAdmin.register User do
  form do |f|
    f.inputs "Users", :multipart => true do
      f.input :avatar, :as => :file, :multipart => true, :label => "Avatar", :hint => f.object.avatar.nil? ? 
        f.template.content_tag(:span, "No Image Yet") : 
        f.template.image_tag(f.object.avatar.url(:thumb)) 
        f.input :avatar_delete, :as=>:boolean, :required => false, :label => 'Remove image' 
      f.input :email
      f.input :active
      f.input :first_name
      f.input :last_name
      f.input :document
      f.input :gender
      f.input :birthday
      f.input :city
      f.input :state
      f.input :country
      f.input :address1
      f.input :address2
      f.input :locale
      f.input :postcode
      f.input :mobile_phone_number
      f.input :newsletter
      f.input :admin_flag
      f.input :password
      f.input :facebook_uid
      f.input :twitter_uid
      f.input :twitter_oauth_token
      f.input :twitter_oauth_secret
      f.input :twitter_oauth_expires_at
      f.input :provider
      f.input :oauth_token
      f.input :oauth_expires_at
    end
    f.buttons
  end

  index do
    column :id
    column :email
    column :first_name
    column :last_name
    column :created_at
    default_actions
  end
   
  show do 
    attributes_table do
      row :id
      row :email
      row :active
      row :first_name
      row :last_name
      row :document
      row :gender
      row :birthday
      row :city
      row :state
      row :country
      row :address1
      row :address2
      row :locale
      row :postcode
      row :mobile_phone_number
      row :newsletter
      row :admin_flag
      row :password
      row :facebook_uid
      row :twitter_uid
      row :twitter_oauth_token
      row :twitter_oauth_secret
      row :twitter_oauth_expires_at
      row :provider
      row :oauth_token
      row :oauth_expires_at
    end
    active_admin_comments
  end
  
end
