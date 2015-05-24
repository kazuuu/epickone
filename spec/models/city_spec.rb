require 'spec_helper'

describe City do
  describe 'Validations' do
    let!(:instance) { FactoryGirl.create :city }
    
    context 'Presence' do 
      it { should validate_presence_of :name }
      it { should validate_presence_of :state_id }
    end
  end
  
  describe 'Associations' do
    it { should belong_to :state }
  end
    
  describe 'mass assignment' do
    context 'no role' do
      it { should allow_mass_assignment_of :id }
      it { should allow_mass_assignment_of :name }
      it { should allow_mass_assignment_of :phone_code }
      it { should allow_mass_assignment_of :state_id }
    end
  end
end