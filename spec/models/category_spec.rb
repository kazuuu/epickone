require 'spec_helper'

describe Category do
  describe 'Validations' do
    let!(:instance) { FactoryGirl.create :cart  }
    
    context 'Presence' do 
      it { should validate_presence_of :title }
    end
  end
  
  describe 'Associations' do
    it { should have_many :events }
  end
  
  describe 'mass assignment' do
    context 'no role' do
      it { should allow_mass_assignment_of :title }
      it { should allow_mass_assignment_of :description }
      it { should allow_mass_assignment_of :sort_order }
      it { should allow_mass_assignment_of :join_type }
      it { should allow_mass_assignment_of :parent_id }
    end
  end
end