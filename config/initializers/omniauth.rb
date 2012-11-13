OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :twitter, 'Consumer key', 'Consumer secret'
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'], :scope => 'email,user_birthday,user_location,user_hometown'
  
end