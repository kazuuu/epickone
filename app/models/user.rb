class User < ActiveRecord::Base
  attr_accessible :email, 
                  :password, 
                  :first_name, 
                  :last_name, 
                  :document,
                  :gender,
                  :birthday,
                  :city_id,
                  :state_id,
                  :country_id,
                  :address1,
                  :address2,
                  :postcode,
                  :mobile_phone_number,
                  :active,
                  :valid_email,
                  :valid_mobile_phone,
                  :admin_flag,
                  :newsletter,
                  :avatar_delete,
                  :facebook_uid,
                  :oauth_token,
                  :oauth_expires_at,
                  :twitter_uid,
                  :twitter_oauth_token,
                  :twitter_oauth_secret,
                  :twitter_oauth_expires_at,
                  :locale,
                  :provider,
                  :emails_attributes

  validates_presence_of :email, 
                        :first_name, 
                        :last_name,
                        :city_id,
                        :state_id,
                        :country_id,
                        :gender,
                        :birthday,
                        :mobile_phone_number 
                        
  validates_presence_of :password, :on => :create
                    
  validates_uniqueness_of :mobile_phone_number

  validates_uniqueness_of :email, :case_sensitive => false

  validates_length_of :mobile_phone_number, :maximum => 9, :minimum => 9

  belongs_to :country
  belongs_to :state
  belongs_to :city
  
  has_many :emails
  has_many :carts
  has_many :tickets, through: :carts

  accepts_nested_attributes_for :emails, allow_destroy: true  

  acts_as_authentic do |c| 
    c.login_field = :email 
    c.require_password_confirmation = false
  end 

  before_validation :default_values
  before_save :destroy_avatar?
  
  has_attached_file  :avatar, 
                     :styles => { :thumb => "100x100>" }, 
                     :storage => :s3,
                     :bucket => ENV['S3_BUCKET'],
                     :s3_credentials => {
                         :access_key_id => ENV['S3_KEY_ID'],
                         :secret_access_key => ENV['S3_ACCESS_KEY']
                       },
                     :default_url => '/images/missing.png'
  validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/png', 'image/gif']
  
  def set_valid_email(valid)
    self.valid_email = valid
    self.save
  end
  
  def default_values
    if self.mobile_phone_number_changed? or self.city_id_changed?
       self.valid_mobile_phone = false
    end
    self.country_id = 1
  end

  def DDD
    if self.city_id.nil?
      "DDD"
    else
      self.city.phone_code
    end
  end
  def gender_formatted
    if self.gender == "F"
      "Feminino"
    elsif self.gender == "M"
      "Masculino"
    else
      "N/A"
    end
      
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

def post_facebook(event_url)
  self.facebook.put_connections("me", "epickone:participar", :evento => event_url)
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

