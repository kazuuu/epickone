class Event < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  attr_accessible :join_min,
                  :join_max,
                  :headline, 
                  :description, 
                  :quiz_id, 
                  :prize_title, 
                  :instruction, 
                  :title, 
                  :enable, 
                  :covering_area, 
                  :start_date,
                  :end_date,
                  :category_id
  #                 :questions_attributes,
  #                 :avatar, 
  #                 :avatar_delete, 
  #                 :photos_attributes, 
  #                 :translations_attributes

  validates_presence_of :title,
                        :headline,
                        :prize_title,
                        :start_date,
                        :end_date
  scope :find_by_date_open, lambda { 
    {
        :conditions => ["date(?) >= date(start_date) and date(?) <= date(end_date)", Date.today, Date.today],
        :order => "end_date asc"
    }
  }

  scope :find_by_category_id, lambda { |term| 
    {
        :conditions => ["category_id = ?", term],
        :order => "end_date asc"
    }
  }
  

  translates :title, :headline, :description, :instruction, :prize_title                
  accepts_nested_attributes_for :translations
  
  class Translation
    attr_accessible :locale, :headline, :title, :description, :instruction, :prize_title
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
                     :bucket => ENV['S3_BUCKET'],
                     :s3_credentials => {
                         :access_key_id => ENV['S3_KEY_ID'],
                         :secret_access_key => ENV['S3_ACCESS_KEY']
                       },
                     :default_url => '/images/missing.png'

  before_save :destroy_avatar?
  
  belongs_to :category
  belongs_to :quiz
  
  has_many :tickets

  has_many :photos, as: :photable
  accepts_nested_attributes_for :photos, allow_destroy: true   
  
  validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/png', 'image/gif']

  def distance_of_time
    distance_of_time_in_words(Time.now, (self.date_due + 1.day).to_date, false, :accumulate_on => :days)
  end
  
  def expired?
    if  Date.today <= self.date_due.to_date 
      false
    else
      true
    end
  end
  
  def ticket_exist(user_id, origin)
    self.tickets.find(:all, :conditions => ["user_id = ? and origin = ?", user_id, origin]).count
  end
  
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