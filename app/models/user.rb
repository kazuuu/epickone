class User < ActiveRecord::Base
  attr_accessible :email, 
                  :password, 
                  :password_salt, 
                  :persistence_token, 
                  :current_login_ip, 
                  :first_name, 
                  :last_name, 
                  :document,
                  :title,
                  :gender,
                  :birth_date,
                  :city,
                  :state,
                  :country,
                  :address1,
                  :address2,
                  :zipcode,
                  :phone_mobile,
                  :admin_flag,
                  :avatar,
                  :avatar_delete
  has_many :draws                 
  has_many :credits
  has_many :carts
  has_many :cartitems
                  
  before_save :destroy_avatar?
  has_attached_file :avatar, 
                    :styles => { :medium => "250x250>", :thumb => "100x100>" }, 
                    :default_url => '/images/missing.png',
                    :storage => :s3,
                    :bucket => 'pkone',
                    :s3_credentials => {
                    :access_key_id => 'AKIAJX6GVL3O5HFMIBJA',
                          :secret_access_key => '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'
                        } 
                    
                    
                    
  validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/png', 'image/gif']
  
  acts_as_authentic do |c| 
    c.login_field = :email 
    c.require_password_confirmation = false
  end 
  
  def total_credits(draw_id)
    # convert to array so it doesn't try to do sum on database directly
    if draw_id.nil?
      credits.to_a.sum(&:value)    
    else  
      credits.find(:all, :conditions => "draw_id=" + draw_id.to_s).to_a.sum(&:value)
    end
  end
  
  def all_draws
    (self.draws + self.draw_owners).uniq
  end  
    
    
    
    
# OMNIAUTH  GEM  
    
    def self.find_or_create_from_oauth(auth_hash)
      provider = auth_hash["provider"]
      uid = auth_hash["uid"]
      case provider
        when 'facebook'
          if user = self.find_by_email(auth_hash["info"]["email"])
            user.update_user_from_facebook(auth_hash)
            return user
          elsif user = self.find_by_facebook_uid(uid)
            return user
          else
            return self.create_user_from_facebook(auth_hash)
          end
        when 'twitter'
          if user = self.find_by_twitter_uid(uid)
            return user
          else
            return self.create_user_from_twitter(auth_hash)
          end
      end
    end

    def self.create_user_from_twitter(auth_hash)
      self.create({
        :twitter_uid => auth_hash["uid"],
        :name => auth_hash["info"]["name"],
        :avatar_url => auth_hash["info"]["image"],
        :crypted_password => "twitter",
        :password_salt => "twitter",
        :persistence_token => "twitter"
      })

    end

    def self.create_user_from_facebook(auth_hash)
      self.create({
        :facebook_uid => auth_hash["uid"],
        :name => auth_hash["info"]["name"],
        :avatar_url => auth_hash["info"]["image"],
        :email => auth_hash["info"]["email"],
        :crypted_password => "facebook",
        :password_salt => "facebook",
        :persistence_token => "facebook"
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

    def update_user_from_facebook(auth_hash)
      self.update_attributes({
        :facebook_uid => auth_hash["uid"],
        :avatar_url => auth_hash["info"]["image"]
      })
    end
# End Omniauth

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
