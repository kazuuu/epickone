class User < ActiveRecord::Base
  attr_accessible :email, 
                  :password, 
                  :password_salt, 
                  :persistence_token, 
                  :perishable_token,
                  :active,
                  :current_login_ip, 
                  :first_name, 
                  :last_name, 
                  :document,
                  :title,
                  :gender,
                  :birthday,
                  :city,
                  :state,
                  :country,
                  :address1,
                  :address2,
                  :zipcode,
                  :phone_mobile,
                  :admin_flag,
                  :avatar_url,
                  :avatar,
                  :avatar_delete,
                  :facebook_uid,
                  :oauth_token,
                  :oauth_expires_at,
                  :twitter_uid,
                  :twitter_oauth_token,
                  :twitter_oauth_secret,
                  :twitter_oauth_expires_at,
                  :locale,
                  :provider
  has_many :events                 
  has_many :carts
  has_many :tickets
                  
  before_save :destroy_avatar?
  has_attached_file  :avatar, 
                     :styles => { :thumb => "100x100>" }, 
                     :storage => :s3,
                     :bucket => 'pkone',
                     :s3_credentials => {
                         :access_key_id => 'AKIAJX6GVL3O5HFMIBJA',
                         :secret_access_key => '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'
                       },
                     :default_url => '/images/missing.png'
                    
                    
                    
  validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/png', 'image/gif']
  validates_uniqueness_of :phone_mobile
  validates_presence_of :phone_mobile
  acts_as_authentic do |c| 
    c.login_field = :email 
    c.require_password_confirmation = false
  end 

  def activate!
    self.active = true
    save
  end
  
  def deliver_activation!
    reset_perishable_token!
    Notifier.activation(self).deliver
  end

  def deliver_welcome!
    reset_perishable_token!
    Notifier.welcome(self).deliver
  end  
      
  def deliver_password_reset_instructions!  
    reset_perishable_token!  
    Notifier.password_reset_instructions(self).deliver 
  end
  
  def all_events
    (self.events + self.event_owners).uniq
  end  
    
# OMNIAUTH  GEM    
  def self.find_or_create_from_oauth(auth_hash)    
    provider = auth_hash.provider
    uid = auth_hash.uid
        
    case provider
      when 'facebook'
        if user = self.find_by_email(auth_hash.info.email)
          user.update_user_from_facebook(auth_hash)          
          return user
        elsif user = self.find_by_facebook_uid(uid)
          return user
        else
          user=self.create_user_from_facebook(auth_hash) 
          user.deliver_welcome!
          return user
        end
      when 'twitter'
        return self.update_user_from_twitter(auth_hash)
    end
  end
  
  def self.update_user_from_twitter(auth_hash)
    self.update_attributes({
      :facebook_uid => auth_hash.uid + "teste"
        })
  end


  def self.create_user_from_facebook(auth_hash)
    birthday = ""
    if auth_hash.extra.nil? == false
      if auth_hash.extra.raw_info.nil? == false
        if auth_hash.extra.raw_info.birthday.nil? == false
          if auth_hash.extra.raw_info.birthday != ""
            birthday = Date.strptime(auth_hash.extra.raw_info.birthday,'%m/%d/%Y')
          else
            birthday = nil
          end
        end
      end
    end
    
    current_city = ""
    if auth_hash.extra.nil? == false
      if auth_hash.extra.location.nil? == false
        if auth_hash.extra.location.name.nil? == false
          current_city = auth_hash.extra.location.name
        end
      end
    end       
    self.create({
      :city => current_city,
#      :state => auth_hash.extra.fetch('location', []).fetch('name', nil),
#      :country => auth_hash.extra.fetch('location', []).fetch('name', nil),
      :gender => auth_hash.extra.gender,
      :birthday => birthday, 
      :avatar => open(auth_hash.info.image),
      :avatar_url => auth_hash.info.image,
      :first_name => auth_hash.info.first_name,
      :last_name => auth_hash.info.last_name,
      :active => true,
      :provider => auth_hash.provider,
      :oauth_token => auth_hash.credentials.token,
      :oauth_expires_at => Time.at(auth_hash.credentials.expires_at),

      :email => auth_hash.info.email,
      :facebook_uid => auth_hash.uid,
      :crypted_password => "facebook",
      :password_salt => "facebook",
      :persistence_token => "facebook"
    })    
  end
  def update_user_from_facebook(auth_hash)
    if auth_hash.extra.raw_info.birthday != ""
      birthday = Date.strptime(auth_hash.extra.raw_info.birthday,'%m/%d/%Y')
    else
      birthday = nil
    end
    self.update_attributes({
      :facebook_uid => auth_hash.uid
        })
  end

    def image
      avatar_url || "http://placehold.it/48x48"
    end

    def password_required?
      facebook_uid.blank? && twitter_uid.blank?
    end

    def email_available?
      twitter_uid.blank?
    end

# End Omniauth

# Koala Gem.
def facebook
  @facebook ||= Koala::Facebook::API.new(oauth_token)
  block_given? ? yield(@facebook) : @facebook
rescue Koala::Facebook::APIError => e
  logger.info e.to_s
  nil
end

def friends_count
  facebook { |fb| fb.get_connection("me", "friends").size }
end

def post_join(user_id, event_url)
  user = User.find(user_id)
  user.facebook.put_connections("me", "epickone:join", :evento => event_url)
end

def post_facebook(event_url)
  self.facebook.put_connections("me", "epickone:join", :evento => event_url)
end

def post_twitter(msg)
  twitter_user = Twitter::Client.new(
    :oauth_token => self.twitter_oauth_token,
    :oauth_token_secret => self.twitter_oauth_secret
  )
  twitter_user.update(msg)
end



# End Koala

# Paperclip for Images
    
    def avatar_delete
      @avatar_delete ||= "0"
    end

    def avatar_delete=(value)
      @avatar_delete = value
    end

    private
      def destroy_avatar?
        self.avatar.clear if @avatar_delete == "1"
      end
# End Paperclip for Images
    
end

