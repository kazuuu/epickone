OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do  

  provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']
  provider :facebook, 
            ENV['FACEBOOK_APP_ID'],
            ENV['FACEBOOK_SECRET'],
            :scope => 'email,user_birthday,user_location,user_hometown,publish_stream,publish_actions',
            :image_size => 'normal'
end