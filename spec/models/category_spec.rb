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
end