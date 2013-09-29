class PaymentNotification < ActiveRecord::Base
  attr_accessible :params, :cart_id, :status, :transaction_id
  belongs_to :cart
  serialize :params
  after_create :mark_cart_as_purchased
  validates_presence_of :params
  
  private
  
  def mark_cart_as_purchased
    if status == "Completed"
      cart.update_attribute(:purchased_at, Time.now)
    end
  end
  
end
