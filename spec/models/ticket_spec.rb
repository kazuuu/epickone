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
  
  describe 'scopes' do
    it 'should find by origin' do
      answered1 = FactoryGirl.create :ticket, :origin => 'answered'
      answered2 = FactoryGirl.create :ticket, :origin => 'answered'
      fb1 = FactoryGirl.create :ticket, :origin => "fb"
      fb2 = FactoryGirl.create :ticket, :origin => "fb"
      fb3 = FactoryGirl.create :ticket, :origin => "fb"
      Ticket.find_by_origin('answered').count.should == 2
      Ticket.find_by_origin('fb').count.should == 3
    end
  end  
end