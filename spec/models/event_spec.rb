require 'spec_helper'

describe Event do
  describe 'Validations' do
    let!(:instance) { FactoryGirl.create :event  }
    
    context 'Presence' do 
      it { should validate_presence_of :title }
      it { should validate_presence_of :headline } 
      it { should validate_presence_of :prize_title } 
      it { should validate_presence_of :start_date } 
      it { should validate_presence_of :end_date } 
    end
    context "translations" do
      it "should read the correct translation" do
        I18n.locale = :"pt-BR"
        e = Event.create title: "Título do Evento"
        I18n.locale = :"en-US"
        e.update_attributes(title: "Event Title")
        
        I18n.locale = :"pt-BR"
        e.title.should == "Título do Evento"

        I18n.locale = :"en-US"
        e.title.should == "Event Title"
      end
    end
    context 'values' do 
    end
  end

  describe 'Associations' do
    it { should have_many :tickets }
    it { should have_many :photos }
    it { should belong_to :quiz }
    it { should belong_to :category }
  end

  describe 'mass assignment' do
    context 'no role' do
      it { should allow_mass_assignment_of :category_id }
      it { should allow_mass_assignment_of :quiz_id }
      it { should allow_mass_assignment_of :headline }
      it { should allow_mass_assignment_of :description }
      it { should allow_mass_assignment_of :prize_title }
      it { should allow_mass_assignment_of :instruction }
      it { should allow_mass_assignment_of :title }
      it { should allow_mass_assignment_of :join_min }
      it { should allow_mass_assignment_of :join_max }
      it { should allow_mass_assignment_of :enable }
      it { should allow_mass_assignment_of :covering_area }
      it { should allow_mass_assignment_of :start_date }
      it { should allow_mass_assignment_of :end_date }
      it { should allow_mass_assignment_of :avatar }
      it { should allow_mass_assignment_of :avatar_delete }
      it { should allow_mass_assignment_of :translations_attributes }
      it { should allow_mass_assignment_of :photos_attributes }
    end
  end
  describe 'scopes' do
  end
end