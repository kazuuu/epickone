class Ticket < ActiveRecord::Base
  attr_accessible :user_id, 
                  :event_id,
                  :picked_number,
                  :origin,
                  :validated_at
  belongs_to :event
  belongs_to :user 

  validates_presence_of :origin,
                        :user_id,
                        :event_id


  scope :find_validated, lambda {
      {
        :conditions => "validated_at is not null"
      }
    }

 
  scope :find_not_validated, lambda {
      {
        :conditions => "validated_at is null"
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
