require 'spec_helper'

describe Answer do
  describe 'Validations' do
    let!(:instance) { FactoryGirl.create :answer }
    
  end
  
  describe 'Associations' do
    it { should belong_to :question }
  end
    
  describe 'mass assignment' do
    context 'no role' do
      it { should allow_mass_assignment_of :answer_text }
    end
  end
end