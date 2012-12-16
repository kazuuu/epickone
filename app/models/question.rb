class Question < ActiveRecord::Base
  attr_accessible :description, :draw_id, :order, :title, :style, :answers_attributes, :avatar, :avatar_delete, :locale, :translations_attributes
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
                     :bucket => 'pkone',
                     :s3_credentials => {
                         :access_key_id => 'AKIAJX6GVL3O5HFMIBJA',
                         :secret_access_key => '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'
                       },
                     :default_url => '/images/missing.png'
  
  belongs_to :draw
  belongs_to :category
  has_many :answers
  accepts_nested_attributes_for :answers, allow_destroy: true

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
