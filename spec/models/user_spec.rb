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
      it { should validate_presence_of :mobile_phone_number }
      it { should validate_presence_of :city_id }
      it { should validate_presence_of :state_id }
      it { should validate_presence_of(:password).on(:create)  }
    end
    
    context 'No presence' do
      it { should_not validate_presence_of(:password).on(:upsate)  }
    end
    
    context 'values' do 
        it { should ensure_length_of(:mobile_phone_number).
                      is_at_least(9).
                      is_at_most(9) }

        it "should have country_id default as 1) Brazil" do
          u = User.new
          u.email = "teste@teste.com.br"
          u.password = 'password' 
          u.first_name = "Teste"
          u.last_name = "Teste"
          u.mobile_phone_number = "999999999" 
          u.document = Faker::PhoneNumberAU.phone_number 
          u.gender = 'Male' 
          u.birthday = '10/10/1980' 
          u.city_id = 1 
          u.state_id = 1 
          u.address1 = Faker::AddressAU.street_address 
          u.address2 = Faker::AddressAU.street_address 
          u.postcode = Faker::AddressAU.postcode
          u.save
          
          u.country_id.should be_equal 1
    
        end

    end
      
    context 'Uniqueness' do
      it { should validate_uniqueness_of(:email) }
      it { should validate_uniqueness_of(:mobile_phone_number) }
    end
  end

  describe 'Associations' do
    it { should have_many :emails }
    it { should belong_to :country }
    it { should belong_to :state }
    it { should belong_to :city }
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
      it { should allow_mass_assignment_of :city_id }
      it { should allow_mass_assignment_of :state_id }
      it { should allow_mass_assignment_of :country_id }
      it { should allow_mass_assignment_of :address1 }
      it { should allow_mass_assignment_of :address2 }
      it { should allow_mass_assignment_of :postcode }
      it { should allow_mass_assignment_of :mobile_phone_number }
      it { should allow_mass_assignment_of :mobile_phone_verification_code }
      it { should allow_mass_assignment_of :admin_flag }
      it { should allow_mass_assignment_of :active }
      it { should allow_mass_assignment_of :valid_email }
      it { should allow_mass_assignment_of :valid_mobile_phone }
      it { should allow_mass_assignment_of :avatar_delete }
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