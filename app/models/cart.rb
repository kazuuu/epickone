class Cart < ActiveRecord::Base
  attr_accessible :cartitems_attributes, :purchased_at, :user_id
  belongs_to :user
  
  has_many :cartitems, :dependent => :destroy
  accepts_nested_attributes_for :cartitems, allow_destroy: true
  
  validates :user_id, presence: true  

  def total_price
    # convert to array so it doesn't try to do sum on database directly
    cartitems.to_a.sum(&:full_price)
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
    cartitems.each_with_index do |item, index|
      values.merge!({
        "amount_#{index+1}" => item.unit_price,
        "item_name_#{index+1}" => item.draw.title,
        "item_number_#{index+1}" => item.id,
        "quantity_#{index+1}" => item.quantity
      })
    end
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
end
