Install:

Before run this application, remember to rename the files listed bellow:
   - /config/environments/production.rb.template to production.rb
   - /config/environments/development.rb.template to development.rb

And set your credentials up in the same files: 
  ENV['FACEBOOK_APP_ID'] = "facebook_id_number";
  ENV['FACEBOOK_SECRET'] = "facebook_secret_number";
  ENV['TWITTER_CONSUMER_KEY'] = "twitter_key_number"
  ENV['TWITTER_CONSUMER_SECRET'] = "twitter_secret_string"

  ENV['S3_BUCKET'] = "S3_bucket_name"
  ENV['S3_KEY_ID'] = "S3_key_string"
  ENV['S3_ACCESS_KEY'] = "S3_access_key_string"

  # SMS Clickatell Configuration
  ENV['clickatell_api_key'] = "clickatell_key_number"
  ENV['clickatell_username'] = "clickatell_username"
  ENV['clickatell_password'] = "clickatell_password" 
