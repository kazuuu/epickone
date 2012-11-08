class Question < ActiveRecord::Base
  attr_accessible :description, :draw_id, :position, :title, :style, :answers_attributes, :avatar, :avatar_delete

  before_save :destroy_avatar?
  
  has_attached_file :avatar, :styles => { :medium => "250x250>", :thumb => "100x100>" }, :default_url => '/images/missing.png'
  
  belongs_to :draw
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
