class Cart < ActiveRecord::Base
  attr_accessible :tickets_attributes, :purchased_at, :user_id
  belongs_to :user
  
  has_many :tickets, :dependent => :destroy
  has_many :cart_products, :dependent => :destroy
  accepts_nested_attributes_for :tickets, allow_destroy: true
  
  validates :user_id, presence: true  

  def ticket_add(event_id, origin)
    new_ticket = tickets.build(:event_id => event_id)
    new_ticket.user_id = self.user_id
    new_ticket.quantity = 1
    if origin == 'paid'
      event = Event.find(event_id)
      new_ticket.unit_price = event.price_ticket
    else
      new_ticket.unit_price = 0
    end
    new_ticket.origin = origin
    if new_ticket.save
      true
    else
      false
    end
  end

  def total_price
    # convert to array so it doesn't try to do sum on database directly
    tickets.to_a.sum(&:full_price)
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
  
  def add_ticket(user_id, event_id, origin)
    event = Event.find(event_id)
    new_ticket = tickets.build(:event_id => event_id)
    new_ticket.user_id = user_id
    new_ticket.quantity = 1
    if origin == 'paid'
      new_ticket.unit_price = event.price_ticket
    else
      new_ticket.unit_price = 0
    end
    new_ticket.origin = origin
    new_ticket.save
    true
  end
  
  def add_product(user_id, product_id, comment)
      product = Product.find(product_id)
      new_item = cart_products.build(:product_id => product_id)
      new_item.user_id = user_id
      new_item.quantity = 1
      new_item.unit_price = product.price_original
      new_item.comment = comment
    if new_item.save
      true
    else
      false
    end
  end  
end
