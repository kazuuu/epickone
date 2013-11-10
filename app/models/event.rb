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
                  :promoter, 
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
                        :promoter,
                        :headline,
                        :prize_title,
                        :start_date,
                        :end_date

  translates :title, :promoter, :headline, :prize_title, :description, :instruction
  accepts_nested_attributes_for :translations
  class Translation
    attr_accessible :locale, :title, :promoter, :headline, :prize_title, :description, :instruction
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
  
   
  scope :find_running, lambda { 
    { 
      :conditions => ["date(?) >= date(start_date) and date(?) <= date(end_date)", Date.today, Date.today] 
    } 
  }

  scope :find_enabled, lambda {
    {
        :conditions => ["enable = true"]
    }
  }
   
  def translations_attributes=(attributes)
    new_translations = attributes.values.reduce({}) do |new_values, translation|
      new_values.merge! translation.delete("locale") => translation
    end
      set_translations new_translations
  end

  def distance_of_time
    distance_of_time_in_words(Time.now, (self.end_date + 1.day).to_date, false,  { :accumulate_on => :days, :highest_measure_only => true })
  end
  
  def expired?
    if  Date.today <= self.end_date.to_date 
      false
    else
      true
    end
  end

  def generate_available_number
    sql = "select num from (select generate_series as num, random() as sort from generate_series(1,#{SETTINGS['TICKET_MAX_NUMBER']}) where generate_series not in (select picked_number from tickets where event_id=#{self.id}) order by sort limit 1) as series;"
    ActiveRecord::Base.connection.execute(sql)
  end
  
  def available_numbers(value, limit_number)
    value = value.to_i.to_s
    sql =  "select cast(num as text) as num from "
    sql << "("
    sql << "  select generate_series as num from generate_series(1,#{SETTINGS['TICKET_MAX_NUMBER']}) where  generate_series not in "
    sql << "  ("
    sql << "    select picked_number from tickets where event_id=#{self.id} "
    sql << "  )"
    sql << ") as series "
    sql << "where cast(num as text) like '%#{value}%' order by  cast(num as int) asc limit #{limit_number};"
    ActiveRecord::Base.connection.execute(sql)
  end
  
  def full?
    if self.tickets.count >= SETTINGS['TICKET_MAX_NUMBER']
      true
    else
      false
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