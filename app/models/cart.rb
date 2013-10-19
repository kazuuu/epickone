class Cart < ActiveRecord::Base
  attr_accessible :tickets_attributes, :purchased_at, :user_id
  
  belongs_to :user
  
  has_many :tickets, :dependent => :destroy
  accepts_nested_attributes_for :tickets, allow_destroy: true
  
  validates_presence_of :user_id
  
  def ticket_add(event_id, origin)
    if !(Event.find(event_id).tickets.find_user_id(user_id).find_all_by_origin(origin).count >= 1)
      new_ticket = tickets.build(:event_id => event_id)
      new_ticket.origin = origin
      new_ticket.save
    else
      false
    end
  end

  def paypal_url(return_url, notify_url)
    values = {
      :business => 'seller_1351513790_biz@gmail.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => id,
      :notify_url => notify_url
    }
    tickets.each_with_index do |item, index|
      if item.unit_price > 0
        values.merge!({
          "amount_#{index+1}" => item.unit_price,
          "item_name_#{index+1}" => item.event.title,
          "item_number_#{index+1}" => item.id,
          "quantity_#{index+1}" => item.quantity
        })
      end
    end
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
end
