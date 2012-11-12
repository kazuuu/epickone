Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :twitter, 'Consumer key', 'Consumer secret'
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'], :scope => 'email,user_birthday,read_stream,first_name,last_name,birthday'
  
end