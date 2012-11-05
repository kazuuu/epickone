class Draw < ActiveRecord::Base
  attr_accessible :description, :title, :avatar, :min_users, :max_users, :localization, :price, :date_due, :date_start, :user_id, :questions_attributes,
                  :avatar, :avatar_delete
                  
  has_attached_file :avatar, :styles => { :medium => "250x250>", :thumb => "100x100>" }, :default_url => '/images/missing.png'
  before_save :destroy_avatar?
  
  belongs_to :user
    
  has_many :carts
  has_many :cartitems
  
  has_many :questions
  accepts_nested_attributes_for :questions, allow_destroy: true   
        
  # presence
  validates :user_id, presence: true  
  validates :title, presence: true
  validates :avatar, presence: true
  validates :description, presence: true
  validates :instruction, presence: true
  validates :min_users, presence: true
  validates :max_users, presence: true
  validates :localization, presence: true
  validates :price, presence: true
  validates :min_users, presence: true
  validates :min_users, presence: true


  validates :title, :length => { :maximum => 25 }

  #validates_attachment_presence :avatar
  validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/png', 'image/gif']

  default_scope order: 'draws.created_at DESC'

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
