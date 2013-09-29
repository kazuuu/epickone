require 'spec_helper'

describe PaymentNotification do
  describe 'Validations' do
    let!(:instance) { FactoryGirl.create :payment_notification  }
    
    context 'Presence' do 
      it { should validate_presence_of :params }
    end
  end
end