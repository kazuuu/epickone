require 'spec_helper'

describe User do
  describe 'Validations' do
    let!(:instance) { FactoryGirl.create :user  }
    
    it { should validate_presence_of :first_name }
  end
end
