require 'spec_helper'

describe State do
  describe 'Validations' do
    let!(:instance) { FactoryGirl.create :state }
    
    context 'Presence' do 
      it { should validate_presence_of :name }
      it { should validate_presence_of :name_code }
      it { should validate_presence_of :country_id }
    end
  end
  
  describe 'Associations' do
    it { should belong_to :country }
    it { should have_many :cities }
  end
    
  
  describe 'mass assignment' do
    context 'no role' do
      it { should allow_mass_assignment_of :id }
      it { should allow_mass_assignment_of :name }
      it { should allow_mass_assignment_of :name_code }
      it { should allow_mass_assignment_of :country_id }
    end
  end
end