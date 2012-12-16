class Draw < ActiveRecord::Base
  #  default_scope order: 'draws.created_at DESC'

  attr_accessible :headline, :description, :instruction, :title, :avatar, :join_type, :join_min, :join_max, :enable, :covering_area, :price_original, :price_ticket, :date_due, :date_start, :user_id, :questions_attributes,
                  :avatar, :avatar_delete, :site_position, :draw_images_attributes, :locale, :translations_attributes, :category_id

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
                     :styles => { :thumb => "100x100>" }, 
                     :storage => :s3,
                     :bucket => 'pkone',
                     :s3_credentials => {
                         :access_key_id => 'AKIAJX6GVL3O5HFMIBJA',
                         :secret_access_key => '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'
                       },
                     :default_url => '/images/missing.png'

  before_save :destroy_avatar?
  
  belongs_to :user
  belongs_to :category
    
  has_many :carts
  has_many :cartitems
  has_many :credits

  has_many :draw_images, :dependent => :destroy
  accepts_nested_attributes_for :draw_images, allow_destroy: true   
  
  has_many :questions
  accepts_nested_attributes_for :questions, allow_destroy: true   
        
  # presence
  validates :user_id, presence: true  
  validates :title, presence: true
  validates :avatar, presence: true
  validates :description, presence: true

  validates :title, :length => { :maximum => 25 }

  #validates_attachment_presence :avatar
  validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/png', 'image/gif']




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
