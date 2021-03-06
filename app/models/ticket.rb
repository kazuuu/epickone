class Ticket < ActiveRecord::Base
  include CommomFunctions

  attr_accessible :user_id, 
                  :event_id,
                  :picked_number,
                  :origin,
                  :submitted_at,
                  :rules
                  
  belongs_to :event
  belongs_to :user 

  validates_presence_of :origin,
                        :user_id,
                        :event_id,
                        :picked_number
  
  validates_numericality_of :picked_number, :only_integer => true, :allow_nil => true, 
      :greater_than_or_equal_to => 1,
      :less_than_or_equal_to => SETTINGS['TICKET_MAX_NUMBER'],
      :message => "apenas números entre 1 e #{SETTINGS['TICKET_MAX_NUMBER']}"                      

  validates_uniqueness_of :picked_number, :scope => [:event_id]
  
  validates_acceptance_of :rules, :on => :update
  
  before_validation :default_values

  scope :find_event, lambda { |term| 
      {
          :conditions => ["event_id = ?", term]
      }
    }
  
  scope :find_validated, lambda {
      {
        :conditions => "submitted_at is not null"
      }
    }

 
  scope :find_not_validated, lambda {
      {
        :conditions => "submitted_at is null"
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

  def picked_number_formatted
    self.picked_number.to_s.rjust(5, '0') 
  end
  
  def default_values
    unless self.created_at?
      x = self.event.generate_available_number
      self.picked_number = x.first["num"].to_i unless x.first.nil?
    end
  end
  
  def add_number(number)
      update_attribute(:picked_number, number)
  end
  def submit_it
    update_attribute(:submitted_at, DateTime.now)
  end
end
