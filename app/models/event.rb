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
                  :category_id,
                  :avatar,
                  :avatar_delete,
                  :translations_attributes,
                  :photos_attributes
                  
  validates_presence_of :title,
                        :headline,
                        :prize_title,
                        :start_date,
                        :end_date

  translates :title, :headline, :prize_title, :description, :instruction                
  accepts_nested_attributes_for :translations
  class Translation
    attr_accessible :locale, :title, :headline, :prize_title, :description, :instruction
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

  
  belongs_to :category
  belongs_to :quiz
  
  has_many :tickets

  has_many :photos, as: :photable
  accepts_nested_attributes_for :photos, allow_destroy: true   

  before_save :destroy_avatar?
  
  validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/png', 'image/gif']

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
  
  def translations_attributes=(attributes)
    new_translations = attributes.values.reduce({}) do |new_values, translation|
      new_values.merge! translation.delete("locale") => translation
    end
      set_translations new_translations
  end
    
  def distance_of_time
    distance_of_time_in_words(Time.now, (self.end_date + 1.day).to_date, false, :accumulate_on => :days)
  end
  
  def expired?
    if  Date.today <= self.end_date.to_date 
      false
    else
      true
    end
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