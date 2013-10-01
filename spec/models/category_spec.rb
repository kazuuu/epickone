require 'spec_helper'

describe Category do
  describe 'Validations' do
    let!(:instance) { FactoryGirl.create :cart  }
    
    context 'Presence' do 
      it { should validate_presence_of :title }
    end
    context "translations" do
      it "should read the correct translation" do
        I18n.locale = :"pt-BR"
        c = Category.create title: "Titulo"
        I18n.locale = :"en-US"
        c.update_attributes(title: "Title")
        
        I18n.locale = :"pt-BR"
        c.title.should == "Titulo"

        I18n.locale = :"en-US"
        c.title.should == "Title"
      end
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
  
  describe 'Translations' do
    let!(:instance) { FactoryGirl.create :cart  }
    
  end
end