require 'spec_helper'

describe Quiz do
  describe 'Validations' do
    let!(:instance) { FactoryGirl.create :ticket }
    
    context 'Presence' do 
      it { should validate_presence_of :title }
    end
  end
  
  describe 'Associations' do
    it { should have_many :events }
    it { should have_many :questions }
  end
    
  describe 'mass assignment' do
    context 'no role' do
      it { should allow_mass_assignment_of :title }
    end
  end
end