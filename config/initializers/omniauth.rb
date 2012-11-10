Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :twitter, 'Consumer key', 'Consumer secret'
  provider :facebook, '547769695238093', '8fb7a869d9548644271b15b96c50e4bd'  
end