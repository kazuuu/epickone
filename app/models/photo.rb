class Photo < ActiveRecord::Base
  attr_accessible :event_id, :image, :image_type, :image_delete, :locale
  
  before_save :destroy_image?
  belongs_to :photable, polymorphic: true
  
  has_attached_file  :image, 
                     :styles => { :thumb => "100x100>" }, 
                     :storage => :s3,
                     :bucket => ENV['S3_BUCKET'],
                     :s3_credentials => {
                         :access_key_id => ENV['S3_KEY_ID'],
                         :secret_access_key => ENV['S3_ACCESS_KEY']
                       },
                     :default_url => '/images/missing.png'
                     
  validates_presence_of :image_file_name

  scope :find_by_image_type, lambda { |term| 
    {
        :conditions => ["image_type = ?", term]
    }
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
