require 'spec_helper'

describe Photo do
  describe 'Validations' do
    let!(:instance) { FactoryGirl.create :photo  }
    
    context 'Presence' do 
      it { should validate_presence_of :image_file_name }
    end
  end
end