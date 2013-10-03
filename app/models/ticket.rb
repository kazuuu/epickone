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


  scope :find_user_id, lambda { |term| 
    {
        :joins => :cart,
        :conditions => ["carts.user_id = ?", term]
    }
  }
  
  scope :find_validated, lambda {
      {
        :joins => :cart,
        :conditions => "carts.purchased_at is not null"
      }
    }

 
  scope :find_not_validated, lambda {
      {
        :joins => :cart,
        :conditions => "carts.purchased_at is null"
      }
    }
  
  scope :find_unumbered, lambda { 
    {
        :conditions => "picked_number is null"
    }
  }
  
  scope :find_running, lambda {
    {
        :joins => :event,
        :conditions => ["date(?) >= events.start_date and date(?) <= date(end_date)", Date.today, Date.today],
        :select => 'tickets.*, events.start_date, events.end_date'
    }
  }

  scope :find_old, lambda {
    {
        :joins => :event,
        :conditions => ["date(?) > date(end_date)", Date.today],
        :select => 'tickets.*, events.start_date, events.end_date'
    }
  }
                          
  def add_number(number)
      update_attribute(:picked_number, number)
  end
end
