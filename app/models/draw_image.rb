class DrawImage < ActiveRecord::Base
  attr_accessible :draw_id, :image, :image_type, :image_delete, :locale
  
  before_save :destroy_image?
  
  belongs_to :draw
  has_attached_file :image, 
                    :styles => { :thumb => "100x100>" }, 
                    :default_url => '/images/missing.png',
                    :storage => :s3,
                    :bucket => 'pkone',
                    :s3_credentials => {
                    :access_key_id => 'AKIAJX6GVL3O5HFMIBJA',
                          :secret_access_key => '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'
                        }

  # Paperclip for Images

      def image_delete
        @image_delete ||= "0"
      end

      def image_delete=(value)
        @image_delete = value
      end

      private
        def destroy_image?
          self.image.clear if @image_delete == "1"
        end
  # End Paperclip

end
