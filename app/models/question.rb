class Question < ActiveRecord::Base
  attr_accessible :description,
                  :quiz_id,
                  :sort_order,
                  :title,
                  :style,
                  :answers_attributes,
                  :avatar,
                  :avatar_delete,
                  :locale,
                  :translations_attributes

  validates_presence_of :sort_order

  translates :title, :description
  accepts_nested_attributes_for :translations
  

  class Translation
    attr_accessible :locale, :title, :description
  end
  def translations_attributes=(attributes)
    new_translations = attributes.values.reduce({}) do |new_values, translation|
      new_values.merge! translation.delete("locale") => translation
    end
      set_translations new_translations
  end  
  
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
  
  belongs_to :quiz
  has_many :answers
  accepts_nested_attributes_for :answers, allow_destroy: true
  
  default_scope order: 'sort_order ASC'

  def right_answer_check(answer_id)
    if self.answers.find_by_right_answer("true").id == answer_id 
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
