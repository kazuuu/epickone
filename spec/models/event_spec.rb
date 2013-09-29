require 'spec_helper'

describe Event do
  describe 'Validations' do
    let!(:instance) { FactoryGirl.create :event  }
    
    context 'Presence' do 
      it { should validate_presence_of :title }
      it { should validate_presence_of :headline } 
      it { should validate_presence_of :prize_title } 
      it { should validate_presence_of :ticket_price } 
      it { should validate_presence_of :start_date } 
      it { should validate_presence_of :end_date } 
    end
  end

  describe 'Associations' do
    it { should have_many :tickets }
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
      it { should allow_mass_assignment_of :ticket_price }
      it { should allow_mass_assignment_of :start_date }
      it { should allow_mass_assignment_of :end_date }
    end
  end
end