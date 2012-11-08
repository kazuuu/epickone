class Answer < ActiveRecord::Base
  attr_accessible :description, :iscorrect, :position, :question_id, :text, :avatar, :avatar_delete
  before_save :destroy_avatar?
  
  belongs_to :question
  has_attached_file :avatar, :styles => { :medium => "250x250>", :thumb => "100x100>" }, :default_url => '/images/missing.png'
  
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
