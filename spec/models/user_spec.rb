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
      it { should validate_presence_of(:password).on(:create)  }
    end
    
    context 'No presence' do
      it { should_not validate_presence_of(:password).on(:upsate)  }
    end
    
    context 'values' do 
      # it 'should purchased_at be nil' do
      #   c = Cart.new
      #   c.user_id = 1
      #   c.purchased_at.should be_nil
      # end
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
      it { should allow_mass_assignment_of :admin_flag }
      it { should allow_mass_assignment_of :active }
      it { should allow_mass_assignment_of :avatar_delete }
      it { should allow_mass_assignment_of :locale }
      it { should allow_mass_assignment_of :newsletter }
      it { should allow_mass_assignment_of :facebook_uid }
      it { should allow_mass_assignment_of :twitter_uid }
      it { should allow_mass_assignment_of :twitter_oauth_token }
      it { should allow_mass_assignment_of :twitter_oauth_secret }
      it { should allow_mass_assignment_of :twitter_oauth_expires_at }
      it { should allow_mass_assignment_of :provider }
      it { should allow_mass_assignment_of :oauth_token }
      it { should allow_mass_assignment_of :oauth_expires_at }
    end
    # context 'Admin role' do
    #   it { should allow_mass_assignment_of(:admin_flag).as(:admin) }
    # end
  end
  
  describe 'abilities' do
    context 'Authentication' do
      it "should acts_as_authentic" do
        u = FactoryGirl.create :user
        u.password_salt.should_not be_nil 
      end
    end
  end
  
  describe 'scopes' do
  end
  
  describe 'callbacks' do
  end
end