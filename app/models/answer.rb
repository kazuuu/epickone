class Answer < ActiveRecord::Base
  attr_accessible :description, :iscorrect, :position, :question_id, :answer_text, :avatar, :avatar_delete, :locale
  before_save :destroy_avatar?
  
  belongs_to :question
  has_attached_file :avatar, 
                    :styles => { :medium => "200x200>", :thumb => "100x100>" }, 
                    :default_url => '/images/missing.png',
                    :storage => :s3,
                    :bucket => 'pkone',
                    :s3_credentials => {
                    :access_key_id => 'AKIAJX6GVL3O5HFMIBJA',
                          :secret_access_key => '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'
                        } 
  
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
