class Answer < ActiveRecord::Base
  attr_accessible :description, :iscorrect, :sort_order, :question_id, :answer_text, :avatar, :avatar_delete, :locale, :translations_attributes

  default_scope order: 'sort_order ASC'  

  before_save :destroy_avatar?
  translates :answer_text, :description
  accepts_nested_attributes_for :translations
  class Translation
    attr_accessible :locale, :answer_text, :description
  end
  def translations_attributes=(attributes)
    new_translations = attributes.values.reduce({}) do |new_values, translation|
      new_values.merge! translation.delete("locale") => translation
    end
      set_translations new_translations
  end  
  
  belongs_to :question
  has_attached_file  :avatar, 
                     :styles => { :thumb => "100x100>" }, 
                     :storage => :s3,
                     :bucket => ENV['S3_BUCKET'],
                     :s3_credentials => {
                         :access_key_id => ENV['S3_KEY_ID'],
                         :secret_access_key => ENV['S3_ACCESS_KEY']
                       },
                     :default_url => '/images/missing.png'
  
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
