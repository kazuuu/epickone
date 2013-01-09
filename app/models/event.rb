class Event < ActiveRecord::Base
  #  default_scope order: 'events.created_at DESC'

  attr_accessible :headline, :description, :instruction, :title, :join_type, :join_min, :join_max, :enable, :covering_area, :price_ticket, :date_due, :date_start, :user_id, :questions_attributes,
                  :avatar, :avatar_delete, :site_position, :photos_attributes, :locale, :translations_attributes, :product_id

  translates :title, :headline, :description, :instruction                  
  accepts_nested_attributes_for :translations
  
  class Translation
    attr_accessible :locale, :headline, :title, :description, :instruction
  end
  def translations_attributes=(attributes)
    new_translations = attributes.values.reduce({}) do |new_values, translation|
      new_values.merge! translation.delete("locale") => translation
    end
      set_translations new_translations
  end  
  has_attached_file  :avatar, 
                     :styles => { :thumb => "100x100>", :medium => "300x300>" }, 
                     :storage => :s3,
                     :bucket => 'pkone',
                     :s3_credentials => {
                         :access_key_id => 'AKIAJX6GVL3O5HFMIBJA',
                         :secret_access_key => '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'
                       },
                     :default_url => '/images/missing.png'

  before_save :destroy_avatar?
  
  belongs_to :user
    
  has_many :carts
  has_many :tickets

  has_many :photos, as: :photable
  accepts_nested_attributes_for :photos, allow_destroy: true   
  
  has_many :questions
  accepts_nested_attributes_for :questions, allow_destroy: true   

  belongs_to :product
  has_one :category, :through => :product

        
  # presence
  validates :user_id, presence: true  
  validates :title, presence: true
  validates :avatar, presence: true
  validates :description, presence: true

  validates :title, :length => { :maximum => 25 }

  #validates_attachment_presence :avatar
  validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/png', 'image/gif']


  def joined
    self.tickets.find(:all, :joins => :cart, :conditions => "carts.purchased_at is not null").count
  end

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
end
