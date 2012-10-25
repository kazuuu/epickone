ActiveAdmin.register User do
  form do |f|
    f.inputs "Users", :multipart => true do
          f.input :avatar
          f.input :email
          f.input :first_name
          f.input :last_name
          f.input :document_number
          f.input :gender
          f.input :birth_date
          f.input :city
          f.input :state
          f.input :country
          f.input :address1
          f.input :address2
          f.input :zipcode
          f.input :phone_mobile
          f.input :admin_flag
          f.input :password
        end
        f.buttons
      end    
end
