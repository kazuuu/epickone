require 'spec_helper'

describe User do
  describe 'Validations' do
    let!(:instance) { FactoryGirl.create :user  }
    
    context 'Presence' do 
      it { should validate_presence_of :email }
      it { should validate_presence_of :password } 
      it { should validate_presence_of :first_name }
      it { should validate_presence_of :last_name }
      it { should validate_presence_of :password }
      it { should validate_presence_of :gender }
      it { should validate_presence_of :birthday }
      it { should validate_presence_of :city }
      it { should validate_presence_of :state }
      it { should validate_presence_of :country }
    end
    
    context 'Uniqueness' do
      it { should validate_uniqueness_of(:email) }
      it { should validate_uniqueness_of(:mobile_phone_number) }
    end
  end

  describe 'Associations' do
    it { should have_many :carts }
    it { should have_many(:tickets).through(:carts)  }
  end

  describe 'mass assignment' do
    context 'no role' do
      it { should allow_mass_assignment_of :email }
      it { should allow_mass_assignment_of :password }
      it { should allow_mass_assignment_of :first_name }
      it { should allow_mass_assignment_of :last_name }
      it { should allow_mass_assignment_of :document }
      it { should allow_mass_assignment_of :gender }
      it { should allow_mass_assignment_of :birthday }
      it { should allow_mass_assignment_of :city }
      it { should allow_mass_assignment_of :state }
      it { should allow_mass_assignment_of :country }
      it { should allow_mass_assignment_of :address1 }
      it { should allow_mass_assignment_of :address2 }
      it { should allow_mass_assignment_of :postcode }
      it { should allow_mass_assignment_of :mobile_phone_number }
      it { should_not allow_mass_assignment_of :admin_flag }
    end
   
    context 'Admin role' do
      it { should allow_mass_assignment_of(:admin_flag).as(:admin) }
    end
  end
end