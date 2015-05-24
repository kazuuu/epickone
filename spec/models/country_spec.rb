require 'spec_helper'

describe Country do
  describe 'Validations' do
    let!(:instance) { FactoryGirl.create :country }
    
    context 'Presence' do 
      it { should validate_presence_of :name }
      it { should validate_presence_of :iso2 }
      it { should validate_presence_of :iso3 }
    end
  end
  
  describe 'Associations' do
    it { should have_many :states }
  end
    
  describe 'mass assignment' do
    context 'no role' do
      it { should allow_mass_assignment_of :id }
      it { should allow_mass_assignment_of :name }
      it { should allow_mass_assignment_of :iso2 }
      it { should allow_mass_assignment_of :iso3 }
      it { should allow_mass_assignment_of :phone_code }
      it { should allow_mass_assignment_of :locale }
    end
  end
end