require 'spec_helper'

describe Question do
  describe 'Validations' do
    let!(:instance) { FactoryGirl.create :question }
    
    context 'Presence' do 
      it { should validate_presence_of :sort_order }
    end
  end
  
  describe 'Associations' do
    it { should have_many :answers }
    it { should belong_to :quiz }
  end
    
  describe 'mass assignment' do
    context 'no role' do
      it { should allow_mass_assignment_of :title }
    end
  end
end