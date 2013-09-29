require 'spec_helper'

describe Ticket do
  describe 'Validations' do
    let!(:instance) { FactoryGirl.create :ticket }
    
    context 'Presence' do 
      it { should validate_presence_of :cart_id }
      it { should validate_presence_of :event_id }
      it { should validate_presence_of :origin }
    end
  end
  
  describe 'Associations' do
    it { should belong_to :cart }
    it { should belong_to :event }
  end
    
  describe 'mass assignment' do
    context 'no role' do
      it { should allow_mass_assignment_of :cart_id }
      it { should allow_mass_assignment_of :event_id }
      it { should allow_mass_assignment_of :origin }
      it { should allow_mass_assignment_of :picked_number }
    end
  end
end