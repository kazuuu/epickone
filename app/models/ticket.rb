class Ticket < ActiveRecord::Base
  attr_accessible :cart_id, 
                  :event_id,
                  :picked_number,
                  :origin
  #belongs_to :cart
  belongs_to :event
  belongs_to :cart 

  validates_presence_of :origin,
                        :cart_id,
                        :event_id


  scope :find_by_origin, lambda { |term| 
    {
        :conditions => ["origin = ?", term],
    }
  }

  scope :find_by_validated, lambda { |term| 
      {
        :joins => :cart,
        :conditions => "carts.purchased_at is not null"
      }
    }

  scope :find_by_user_id, lambda { |term| 
    {
        :joins => :cart,
        :conditions => ["carts.user_id = ?", term]
    }
  }

                        
  def add_number(number)
      update_attribute(:picked_number, number)
  end
end
