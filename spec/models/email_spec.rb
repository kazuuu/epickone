require 'spec_helper'

describe Email do
  describe 'Validations' do
    let!(:instance) { FactoryGirl.create :email }
    
    context 'Presence' do 
      it { should validate_presence_of :user_id }
      it { should validate_presence_of :email }
      it { should validate_presence_of :token }
    end
  end
  
  describe 'Associations' do
    it { should belong_to :user }
  end
    
  describe 'mass assignment' do
    context 'no role' do
      it { should allow_mass_assignment_of :user_id }
      it { should allow_mass_assignment_of :email }
      it { should allow_mass_assignment_of :valid_email }
      it { should allow_mass_assignment_of :token }
    end
  end
end