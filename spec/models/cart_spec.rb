require 'spec_helper'

describe Cart do
  describe 'Validations' do
    let!(:instance) { FactoryGirl.create :cart  }
    
    context 'Presence' do 
      it { should validate_presence_of :user_id }
    end
    
    context 'values' do 
      it 'should purchased_at be nil' do
        c = Cart.new
        c.user_id = 1
        c.purchased_at.should be_nil
      end
    end
  end

  describe 'Associations' do
    it { should belong_to :user }
    it { should have_many(:tickets) }
  end

  describe 'mass assignment' do
    context 'no role' do
      it { should allow_mass_assignment_of :purchased_at }
      it { should allow_mass_assignment_of :user_id }
      it { should allow_mass_assignment_of :tickets_attributes }
    end
  end
end