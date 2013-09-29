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



# require 'spec_helper'
# require "cancan/matchers"
# 
# describe User do
#   describe 'validations' do
#     let!(:instance) { FactoryGirl.create :user  }
# 
#     it { should validate_presence_of :display_name }
#     it { should validate_presence_of :email     }
#     it { should validate_presence_of :password  }
# 
#     context 'user signing up' do
#       it { should_not validate_presence_of :mobile_number }
#       it { should_not validate_presence_of :street_address }
#       it { should_not validate_presence_of :suburb }
#       it { should_not validate_presence_of :postcode }
#       it { should_not validate_presence_of :dob }
#       it { should_not validate_presence_of :gender }
#     end
# 
#     context 'user signed up' do
# 
#       subject { FactoryGirl.create(:user) }
# 
#       it { should validate_presence_of :mobile_number }
#       it { should validate_presence_of :street_address }
#       it { should validate_presence_of :suburb }
#       it { should validate_presence_of :postcode }
#       it { should validate_presence_of :dob }
#       it { should validate_presence_of :gender }
# 
#     end
#   end
# 
#   describe 'relationships' do
#     it { should have_many(:roles).through(:role_users)  }
#     it { should have_many :role_users                   }
#     it { should have_many(:groups).through(:group_users) }
#     it { should have_many(:group_users) }
#     it { should have_many(:missions).through(:groups) }
#     it { should have_many(:captain_joined_missions).dependent(:destroy) }
#     it { should have_many(:captain_missions).through(:captain_joined_missions) }
#     it { should have_many(:sidekick_mission_reviews) }
#     it { should have_many(:captain_mission_reviews) }
#     it { should have_many(:non_profit_mission_reviews) }
#     it { should have_many(:coaching_sessions) }
#     it { should have_many(:sent_messages) }
#     it { should have_many(:donations) }
#     it { should have_many(:training_attendees) }
#     it { should have_many(:trainings).through(:training_attendees) }
#   end
# 
#   describe 'mass assignment' do
# 
#     context 'no role' do
#       it { should allow_mass_assignment_of :family_name }
#       it { should allow_mass_assignment_of :given_name }
#       it { should allow_mass_assignment_of :display_name }
#       it { should allow_mass_assignment_of :email }
#       it { should allow_mass_assignment_of :password }
#       it { should allow_mass_assignment_of :remember_me }
#       it { should allow_mass_assignment_of :share_details }
#       it { should_not allow_mass_assignment_of :role_ids }
#       it { should_not allow_mass_assignment_of :group_ids }
#     end
# 
#     context 'overlord' do
#       it { should allow_mass_assignment_of(:family_name).as(:overlord) }
#       it { should allow_mass_assignment_of(:given_name).as(:overlord) }
#       it { should allow_mass_assignment_of(:display_name).as(:overlord) }
#       it { should allow_mass_assignment_of(:email).as(:overlord) }
#       it { should allow_mass_assignment_of(:password).as(:overlord) }
#       it { should allow_mass_assignment_of(:remember_me).as(:overlord) }
#       it { should allow_mass_assignment_of(:role_ids).as(:overlord) }
#       it { should allow_mass_assignment_of(:group_ids).as(:overlord) }
#       it { should allow_mass_assignment_of(:share_details).as(:overlord) }
#     end
#   end
# 
#   describe 'abilities' do
# 
#     subject { ability }
# 
#     let(:ability){ Ability.new(user) }
# 
#     describe 'league wall posts' do
#       let!(:league) { FactoryGirl.create :league }
#       let!(:user)   { FactoryGirl.create :sidekick }
#       let!(:post)   { FactoryGirl.build :wall_post, league: league, user: user }
# 
#       context 'user is not in a league' do
#         it { should_not be_able_to :create, post }
#       end
# 
#       context 'user is in a league' do
#         before :each do
#           user.leagues << league
#         end
# 
#         it { should be_able_to :create, post }
#       end
#     end
# 
#     context 'user is an overlord' do
# 
#       let!(:user) { FactoryGirl.create(:overlord) }
# 
#       it { should be_able_to(:manage, :all) }
#       it { should be_able_to(:complete, Mission) }
# 
#     end
# 
#     context 'user is in a non profit group' do
# 
#       let(:user)            { FactoryGirl.create(:user) }
#       let(:group_a)         { FactoryGirl.create(:non_profit_group) }
#       let(:group_b)         { FactoryGirl.create(:vetter_group) }
#       let(:group_c)         { FactoryGirl.create(:flagged_non_profit_group) }
#       let(:mission_a)       { FactoryGirl.build(:mission, group_id: group_a.id) }
#       let(:mission_b)       { FactoryGirl.build(:mission, group_id: group_b.id) }
#       let(:mission_c)       { FactoryGirl.build(:mission, group_id: group_c.id) }
#       let(:mission_d)       { FactoryGirl.create(:reviewable_mission, group_id: group_a.id) }
#       let(:mission_e)       { FactoryGirl.create(:reviewable_mission, group_id: group_c.id) }
#       let(:public_mission)  { FactoryGirl.create(:public_mission) }
# 
#       context "Mission creation" do
# 
#         before(:each) do
#           user.groups << group_a
#           user.groups << group_c
#         end
# 
#         it { should be_able_to(:read, public_mission) }
#         it { should be_able_to(:create, mission_a) }
#         it { should_not be_able_to(:create, mission_c) }
#         it { should be_able_to(:update, mission_a) }
#         it { should_not be_able_to(:create, mission_b) }
#         it { should be_able_to(:read, group_a)}
#         it { should_not be_able_to(:read, group_b)}
# 
#       end
# 
#       context "Mission editing" do
# 
#         let(:draft_mission)       { FactoryGirl.create :draft_mission, group: group_a }
#         let(:rejected_mission)    { FactoryGirl.create :rejected_mission, group: group_a }
#         let(:vettable_mission)    { FactoryGirl.create :mission, state: 'ready_for_vetting', group: group_a }
#         let(:vetted_mission)      { FactoryGirl.create :vetted_mission, group: group_a }
#         let(:reviewable_mission)  { FactoryGirl.create :reviewable_mission, group: group_a }
#         before(:each)             { user.groups << group_a }
# 
#         it { should be_able_to(:edit, draft_mission) }
#         it { should be_able_to(:edit, rejected_mission) }
#         it { should be_able_to(:edit, vettable_mission) }
#         it { should_not be_able_to(:edit, vetted_mission) }
#         it { should_not be_able_to(:edit, reviewable_mission) }
#         it { should be_able_to(:update, draft_mission) }
#         it { should be_able_to(:update, rejected_mission) }
#         it { should be_able_to(:update, vettable_mission) }
#         it { should_not be_able_to(:update, vetted_mission) }
#         it { should_not be_able_to(:update, reviewable_mission) }
# 
#       end
# 
#       context "group editing" do
# 
#         before(:each) do
#           user.groups << group_a
#         end
# 
#         it { should be_able_to :update, group_a }
#         it { should_not be_able_to :update, group_b }
# 
#       end
# 
#       context "review" do
# 
#         let(:review_a)  { FactoryGirl.create :non_profit_mission_review, mission: mission_d }
#         let(:review_b)  { FactoryGirl.create :non_profit_mission_review, mission: mission_e }
#         before(:each)   { user.groups << group_a }
# 
#         it { should be_able_to :new, NonProfitMissionReview }
#         it { should be_able_to :create, review_a }
#         it { should_not be_able_to :create, review_b }
# 
#       end
# 
#     end
# 
#     context 'user is a vetter' do
# 
#       let(:user)          { FactoryGirl.create(:vetter) }
#       let(:mission)       { FactoryGirl.create(:mission) }
#       let(:mission_vet )  { FactoryGirl.build(:approved_mission_vet) }
#       let(:group)         { FactoryGirl.create(:group) }
#       before(:each)       { user.groups << group }
# 
#       it { should be_able_to(:read, mission) }
#       it { should be_able_to(:create, mission_vet) }
#       it { should be_able_to(:read, group) }
# 
# 
#     end
# 
#     context "user is a captain" do
# 
#       let(:user)              { FactoryGirl.create(:captain) }
# 
#       let(:group)             { FactoryGirl.create(:league) }
# 
# 
#       context 'missions' do
# 
#         let(:public_mission)    { FactoryGirl.create(:public_mission) }
#         let(:joinable_mission)  { FactoryGirl.create(:captain_joinable_mission) }
#         let(:joined_mission)    { FactoryGirl.create(:captain_joinable_mission) }
#         let(:mission)           { FactoryGirl.create(:mission) }
#         let(:sidekick)          { FactoryGirl.create(:user) }
#         before(:each)           { joinable_mission.add_captain user }
#         let(:sjm)               { SidekickJoinedMission.create user_id: sidekick.id, mission_id: joinable_mission.id }
# 
#         it { should be_able_to(:read, joinable_mission) }
#         it { should be_able_to(:read, joined_mission) }
#         it { should_not be_able_to(:read, mission) }
#         it { should be_able_to(:read, public_mission) }
#         it { should be_able_to(:check_in_sidekick, sjm) }
# 
#       end
# 
#       context 'groups' do
# 
#         let(:group)         { FactoryGirl.create(:group) }
#         before(:each)       { user.groups << group }
# 
#         it { should be_able_to(:read, group) }
# 
#       end
# 
#       context 'review' do
# 
#         it { should be_able_to(:new, CaptainMissionReview) }
# 
#         context 'user has joined mission as a captain' do
# 
#           let(:captain_mission_review)   { FactoryGirl.build :captain_mission_review, reviewer: user }
# 
#           it { should be_able_to(:create, captain_mission_review) }
# 
#         end
# 
#         context 'user has not joined mission' do
# 
#           let(:captain_mission_review)   { FactoryGirl.build :captain_mission_review }
# 
#           it { should_not be_able_to(:create, captain_mission_review) }
# 
#         end
# 
#       end
# 
#       context 'completion' do
# 
#         let(:mission_a) { FactoryGirl.create :vetted_mission }
#         let(:mission_b) { FactoryGirl.create :vetted_mission }
#         before(:each)   { mission_a.add_captain user }
# 
#         it { should be_able_to :complete, mission_a }
#         it { should_not be_able_to :complete, mission_b }
# 
#       end
# 
#       context 'messaging' do
#         let!(:non_profit_user) { FactoryGirl.create :non_profit }
#         let!(:captain)         { FactoryGirl.create :captain }
#         let!(:sidekick)        { FactoryGirl.create :user }
#         let!(:mission_a)       { FactoryGirl.create :vetted_mission, group: non_profit_user.nfp_groups.first }
#         let!(:mission_b)       { FactoryGirl.create :sidekick_joinable_mission }
#         let!(:message_a)       { FactoryGirl.create :message, sender: user, recipients: [non_profit_user] }
#         let!(:message_b)       { FactoryGirl.create :message, sender: user, recipients: [non_profit_user, captain] }
#         let!(:message_c)       { FactoryGirl.create :message, sender: user, recipients: [sidekick] }
# 
#         before(:each) do
#           mission_b.add_sidekick sidekick
#           mission_a.add_captain user
#           mission_b.add_captain user
#         end
# 
# 
#         it { should be_able_to :new, Message }
#         it { should be_able_to :create, message_a }
#         it { should be_able_to :edit, message_a }
#         it { should be_able_to :update, message_a }
#         it { should be_able_to :confirm, message_a }
#         it { should be_able_to :send_message, message_a }
#         it { should be_able_to :destroy, message_a }
#         it { should be_able_to :create, message_c }
#         it { should be_able_to :edit, message_c }
#         it { should be_able_to :update, message_c }
#         it { should be_able_to :confirm, message_c }
#         it { should be_able_to :send_message, message_c }
#         it { should be_able_to :destroy, message_c }
#         it { should_not be_able_to :create, message_b }
#         it { should_not be_able_to :edit, message_b }
#         it { should_not be_able_to :update, message_b }
#         it { should_not be_able_to :confirm, message_b }
#         it { should_not be_able_to :send_message, message_b }
#         it { should_not be_able_to :destroy, message_b }
# 
#       end
# 
#     end
# 
#     context 'user is a superhero coach' do
# 
#       let(:user)      { FactoryGirl.create :superhero_coach }
# 
#       it { should be_able_to(:manage, Training) }
# 
#     end
# 
#     context 'user is a sidekick' do
# 
#       let(:user)              { FactoryGirl.create(:sidekick) }
# 
# 
#       context 'missions' do
# 
#         let(:public_mission)    { FactoryGirl.create(:public_mission) }
#         let(:joined_mission)    { FactoryGirl.create(:sidekick_joinable_mission) }
#         let(:sidekick)          { FactoryGirl.create(:user)}
#         let(:sjm_a)             { FactoryGirl.create :sidekick_joined_mission, user_id: user.id, mission_id: joined_mission.id }
#         let(:sjm_b)             { FactoryGirl.create :sidekick_joined_mission, user_id: sidekick.id, mission_id: joined_mission.id }
# 
#         it { should be_able_to(:read, public_mission) }
#         it { should be_able_to(:read, joined_mission) }
#         it { should be_able_to(:check_in_as_sidekick, sjm_a) }
#         it { should_not be_able_to(:check_in_as_sidekick, sjm_b) }
# 
#       end
# 
#       context 'groups' do
# 
#         let(:group)   { FactoryGirl.create(:group) }
#         before(:each) { user.groups << group }
# 
#         it { should be_able_to(:read, group) }
# 
#       end
# 
#       context "review" do
#         let(:mission) { FactoryGirl.create :vetted_mission }
#         let(:captain) { FactoryGirl.create :captain }
# 
#         it { should be_able_to(:new, SidekickMissionReview) }
# 
#         context 'user has joined mission' do
# 
#           before :each do
#             mission.add_captain captain
#             mission.add_sidekick user
#             mission.complete
#           end
#           let(:review)   { FactoryGirl.build :sidekick_mission_review, reviewer: user, captain: captain, mission: mission }
# 
#           it { should be_able_to(:create, review) }
# 
#         end
# 
#         context 'user has not joined mission' do
# 
#           before :each do
#             mission.add_captain captain
#             mission.complete
#           end
#           let(:review)   { FactoryGirl.build :sidekick_mission_review, reviewer: user, captain: captain, mission: mission }
# 
#           it { should_not be_able_to(:create, review) }
# 
#         end
# 
#       end
# 
#     end
# 
#     context 'viewing captain applications' do
#       let!(:sidekick)    { FactoryGirl.create :sidekick }
#       let!(:other_user)  { FactoryGirl.create :sidekick }
#       let!(:coach)       { FactoryGirl.create :superhero_coach }
#       let!(:application) { FactoryGirl.create :captain_application, user: sidekick }
# 
#       it 'allows sidekicks to read their own applications' do
#         Ability.new(sidekick).should be_able_to :read, application
#       end
# 
#       it 'does not allow other sidekicks to read their applications' do
#         Ability.new(other_user).should_not be_able_to :read, application
#       end
# 
#       it 'allows coaches to read applications' do
#         Ability.new(coach).should be_able_to :read, application
#       end
# 
#       it 'does not allow sidekicks to edit their own applications' do
#         Ability.new(sidekick).should_not be_able_to :update, application
#       end
# 
#       it 'allows coaches to edit applications' do
#         Ability.new(coach).should be_able_to :update, application
#       end
#     end
# 
#     context 'managing league requests' do
#       let!(:user) { FactoryGirl.create :sidekick }
#       let!(:league) { FactoryGirl.create :league }
# 
#       context 'user is a member of league' do
#         before :each do
#           user.leagues << league
#         end
# 
#         it { should be_able_to :manage_requests, league }
#       end
# 
#       context 'user is not a member of league' do
#         it { should_not be_able_to :manage_requests, league }
#       end
#     end
# 
#   end
# 
#   context 'scopes' do
# 
#     describe ".with_role" do
# 
#       let!(:user) { FactoryGirl.create :captain }
# 
#       subject { User.with_role(role) }
# 
#       context 'user has role' do
# 
#         let(:role)  { :captain }
# 
#         it { should include user }
# 
#       end
# 
#       context 'does not have role' do
# 
#         let(:role)  { :overlord }
# 
#         it { should_not include user }
# 
#       end
# 
#     end
# 
# 
#     describe '.missions_attended' do
# 
#       let(:user_a)    { FactoryGirl.create :captain }
#       let(:user_b)    { FactoryGirl.create :captain }
#       let(:user_c)    { FactoryGirl.create :captain }
#       let(:user_d)    { FactoryGirl.create :captain }
#       let(:mission_a) { FactoryGirl.create :vetted_mission }
#       let(:mission_b) { FactoryGirl.create :vetted_mission }
#       let(:mission_c) { FactoryGirl.create :vetted_mission }
# 
#       before(:each) do
#         mission_a.add_captain user_a
#         mission_a.add_captain user_b
#         mission_b.add_captain user_c
#         mission_c.add_captain user_a
#         mission_a.add_sidekick user_d
#         mission_b.add_sidekick user_a
#         mission_c.add_sidekick user_b
#       end
# 
#       subject { User.missions_attended 2, operator }
# 
#       context 'less than threshold' do
# 
#         let(:operator) { :less_than }
# 
#         it            { should include user_c }
#         it            { should include user_d }
#         its(:length)  { should == 2 }
# 
#       end
# 
#       context 'greater than threshold' do
# 
#         let(:operator) { :greater_than }
# 
#         it            { should include user_a }
#         its(:length)  { should == 1 }
# 
#       end
# 
#       context 'equal to threshold' do
# 
#         let(:operator) { :equal_to }
# 
#         it            { should include user_b }
#         its(:length)  { should == 1 }
# 
#       end
# 
#     end
# 
#     describe '.in_postcode' do
# 
#       let!(:user_a)  { FactoryGirl.create :user, postcode: "9001" }
#       let!(:user_b)  { FactoryGirl.create :user, postcode: "8999" }
# 
#       subject { User.in_postcode "9001" }
# 
#       it { should include user_a }
#       it { should_not include user_b }
# 
#     end
# 
#     describe '.last_visited_site' do
# 
#       let!(:user_a)  { FactoryGirl.create :user, last_sign_in_at: Time.now }
#       let!(:user_b)  { FactoryGirl.create :user, last_sign_in_at: 6.months.ago }
# 
#       subject { User.last_visited_site 2.weeks.ago }
# 
#       it { should include user_b }
#       it { should_not include user_a }
# 
#     end
# 
#     describe '.in_leagues' do
#       let(:league_member_a) { FactoryGirl.create :league_member }
#       let(:league_member_b) { FactoryGirl.create :league_member }
#       let(:league_member_c) { FactoryGirl.create :league_member }
#       subject { User.in_leagues(leagues) }
# 
#       context 'when specifying a single league' do
#         let(:leagues) { league_member_a.league }
# 
#         it { should include league_member_a.user }
#         it { should_not include league_member_b.user }
#         it { should_not include league_member_c.user }
#       end
# 
#       context 'when specifying an array of leagues' do
#         let(:leagues) { [league_member_b.league, league_member_c.league] }
# 
#         it { should_not include league_member_a.user }
#         it { should include league_member_b.user }
#         it { should include league_member_c.user }
#       end
#     end
# 
#   end
# 
#   describe 'callbacks' do
# 
#     context 'before create' do
# 
#       let(:token)   { 'iamtoken' }
#       before(:each) { SecureRandom.should_receive(:hex).and_return(token) }
# 
#       subject { FactoryGirl.create :user }
# 
#       its(:api_token) { should == token }
# 
#     end
# 
#   end
# 
#   describe '#contactable_non_profit_user_ids' do
# 
#     let!(:non_profit_user_a)  { FactoryGirl.create :non_profit }
#     let!(:non_profit_user_b)  { FactoryGirl.create :non_profit }
#     let!(:user)               { FactoryGirl.create :captain }
# 
#     subject { user.contactable_non_profit_user_ids }
# 
#     context 'user has captain missions' do
# 
#       let!(:mission) { FactoryGirl.create :vetted_mission, group: non_profit_user_a.nfp_groups.first }
# 
#       before :each do
#         mission.add_captain user
#       end
# 
#       it { should include non_profit_user_a.id }
#       it { should_not include non_profit_user_b.id }
# 
#     end
# 
#     context 'user has no captain missions' do
#       it { should be_empty }
#     end
# 
#   end
# 
#   describe '#contactable_sidekicks_user_ids' do
# 
#     let!(:sidekick_a) { FactoryGirl.create :sidekick }
#     let!(:sidekick_b) { FactoryGirl.create :sidekick }
#     let!(:user)       { FactoryGirl.create :captain }
# 
#     subject { user.contactable_sidekicks_user_ids }
# 
#     context 'user has captain missions' do
# 
#       let!(:mission) { FactoryGirl.create :sidekick_joinable_mission }
# 
#       before :each do
#         mission.add_captain user
#         mission.add_sidekick sidekick_a
#       end
# 
#       it { should include sidekick_a.id }
#       it { should_not include sidekick_b.id }
# 
#     end
# 
#     context 'user has no captain missions' do
#       it { should be_empty }
#     end
# 
#   end
# 
#   describe '#contactable_user_ids' do
# 
#     let!(:sidekick)  { FactoryGirl.create :sidekick }
#     let!(:user)      { FactoryGirl.create :captain }
#     let!(:non_profit_user)  { FactoryGirl.create :non_profit }
# 
#     subject { user.contactable_user_ids }
# 
#     context 'user has captain missions' do
# 
#       let!(:mission) do
#         FactoryGirl.create :sidekick_joinable_mission,
#                             group: non_profit_user.nfp_groups.first
#       end
# 
#       before :each do
#         mission.add_captain user
#         mission.add_sidekick sidekick
#       end
# 
#       it { should include sidekick.id }
#       it { should include non_profit_user.id }
# 
#     end
# 
#     context 'user has no captain missions' do
#       it { should be_empty }
#     end
#   end
# 
#   describe '.with_accepted_applications' do
#     let!(:rejected_app) { FactoryGirl.create :rejected_captain_application }
#     let!(:accepted_app) { FactoryGirl.create :accepted_captain_application }
# 
#     subject { User.with_accepted_applications }
#     it { should_not include rejected_app.user }
#     it { should include accepted_app.user }
#   end
# 
#   describe '.completed_signup' do
#     let(:incomplete_user) { FactoryGirl.create :incomplete_user }
#     let(:normal_user)     { FactoryGirl.create :user }
# 
#     subject { User.completed_registration }
# 
#     it { should include normal_user }
#     it { should_not include incomplete_user }
#   end
# 
#   describe '#reviewed_mission?' do
# 
#     context 'has reviewed mission' do
# 
#       let!(:mission)  { FactoryGirl.create :vetted_mission }
#       let!(:sidekick) { FactoryGirl.create :user }
#       let!(:captain)  { FactoryGirl.create :captain }
#       before :each do
#         mission.add_captain captain
#         mission.add_sidekick sidekick
#         mission.complete
#       end
# 
#       context 'as sidekick' do
# 
#         let!(:review)  do
#           FactoryGirl.create :sidekick_mission_review,  reviewer: sidekick, captain: captain, mission: mission
#         end
# 
#         subject { sidekick.reviewed_mission?(:sidekick, review.mission) }
# 
#         it { should be_true }
# 
#       end
# 
#       context 'as captain' do
# 
#         let!(:review)  do
#           FactoryGirl.create :captain_mission_review, reviewer: captain, mission: mission
#         end
# 
#         subject { captain.reviewed_mission?(:captain, mission) }
# 
#         it { should be_true }
# 
#       end
# 
#     end
# 
#     context 'has not reviewed mission' do
# 
#       let!(:mission)  { FactoryGirl.create :vetted_mission }
#       let!(:sidekick) { FactoryGirl.create :user }
#       let!(:captain)  { FactoryGirl.create :captain }
#       before :each do
#         mission.add_captain captain
#         mission.add_sidekick sidekick
#         mission.complete
#       end
# 
#       context 'as sidekick' do
# 
#         subject { sidekick.reviewed_mission?(:sidekick, mission) }
# 
#         it { should be_false }
# 
#       end
# 
#       context 'as captain' do
# 
#         subject { captain.reviewed_mission?(:captain, mission) }
# 
#         it { should be_false }
# 
#       end
# 
#     end
# 
#   end
# 
#   describe '#joined_mission?' do
# 
#     context "captain" do
# 
#       let!(:captain)  { FactoryGirl.create(:captain) }
# 
#       subject { captain.joined_mission?(:captain, mission) }
# 
#       context 'captain has joined mission' do
# 
#         let!(:mission)  { FactoryGirl.create(:captain_joinable_mission) }
#         before(:each)   { mission.add_captain captain }
# 
#         it { should be_true }
# 
#       end
# 
#       context 'captain has not joined mission' do
# 
#         let!(:mission)  { FactoryGirl.create(:draft_mission) }
# 
#         it { should be_false }
# 
#       end
# 
#     end
# 
# 
#     context 'sidekick' do
# 
#       let!(:sidekick)  { FactoryGirl.create(:sidekick) }
# 
#       subject { sidekick.joined_mission?(:sidekick, mission) }
# 
#       context 'sidekick has joined mission' do
# 
#         let!(:mission)  { FactoryGirl.create(:sidekick_joinable_mission) }
#         before(:each)   { mission.add_sidekick sidekick }
# 
#         it { should be_true }
# 
#       end
# 
#       context 'sidekick has not joined mission' do
# 
#         let!(:mission)  { FactoryGirl.create(:draft_mission) }
# 
#         it { should be_false }
# 
#       end
# 
#     end
# 
#   end
# 
#   context 'mission membership' do
#     context 'lead captain on mission' do
#       let!(:mission) { FactoryGirl.create :captain_joinable_mission }
#       subject { FactoryGirl.create :captain }
# 
#       before :each do
#         mission.add_captain subject
#       end
# 
#       it { should be_lead_captain_of mission }
#       it { should be_captain_of mission }
#       it { should_not be_sidekick_of mission }
#       it { should_not be_non_profit_of mission }
#       it { should be_involved_in mission }
#     end
# 
#     context 'non-lead captain on mission' do
#       let!(:mission) { FactoryGirl.create :captain_joinable_mission }
#       let!(:lead_captain) { FactoryGirl.create :captain }
#       subject { FactoryGirl.create :captain }
# 
#       before :each do
#         mission.add_captain lead_captain
#         mission.add_captain subject
#       end
# 
#       it { should_not be_lead_captain_of mission }
#       it { should be_captain_of mission }
#       it { should_not be_sidekick_of mission }
#       it { should_not be_non_profit_of mission }
#       it { should be_involved_in mission }
#     end
# 
#     context 'captain not on mission' do
#       let!(:mission) { FactoryGirl.create :captain_joinable_mission }
#       subject { FactoryGirl.create :captain }
# 
#       it { should_not be_lead_captain_of mission }
#       it { should_not be_captain_of mission }
#       it { should_not be_sidekick_of mission }
#       it { should_not be_non_profit_of mission }
#       it { should_not be_involved_in mission }
#     end
# 
#     context 'sidekick on mission' do
#       let!(:mission) { FactoryGirl.create :sidekick_joinable_mission }
#       subject { FactoryGirl.create :sidekick }
# 
#       before :each do
#         mission.add_sidekick subject
#       end
# 
#       it { should_not be_lead_captain_of mission }
#       it { should_not be_captain_of mission }
#       it { should be_sidekick_of mission }
#       it { should_not be_non_profit_of mission }
#       it { should be_involved_in mission }
#     end
# 
#     context 'sidekick not on mission' do
#       let!(:mission) { FactoryGirl.create :sidekick_joinable_mission }
#       subject { FactoryGirl.create :sidekick }
# 
#       it { should_not be_lead_captain_of mission }
#       it { should_not be_captain_of mission }
#       it { should_not be_sidekick_of mission }
#       it { should_not be_non_profit_of mission }
#       it { should_not be_involved_in mission }
#     end
# 
#     context 'non-profit belonging to mission' do
#       let!(:mission) { FactoryGirl.create :public_mission }
#       subject { FactoryGirl.create :non_profit }
# 
#       before :each do
#         mission.group = subject.nfp_groups.first
#         mission.save!
#       end
# 
#       it { should_not be_lead_captain_of mission }
#       it { should_not be_captain_of mission }
#       it { should_not be_sidekick_of mission }
#       it { should be_non_profit_of mission }
#       it { should be_involved_in mission }
#     end
# 
#     context 'non-profit not belonging to mission' do
#       let!(:mission) { FactoryGirl.create :public_mission }
#       subject { FactoryGirl.create :non_profit }
# 
#       it { should_not be_lead_captain_of mission }
#       it { should_not be_captain_of mission }
#       it { should_not be_sidekick_of mission }
#       it { should_not be_non_profit_of mission }
#       it { should_not be_involved_in mission }
#     end
# 
#   end
# 
#   describe '#has_role?' do
# 
#     let(:overlord_role) { FactoryGirl.create(:overlord_role)  }
#     let(:user)          { FactoryGirl.create(:user)           }
#     before(:each)       { user.roles << overlord_role         }
# 
#     subject { user.has_role? role }
# 
#     context 'user has role' do
# 
#       let(:role) { :overlord }
# 
#       it { should be_true }
# 
#     end
# 
#     context 'user does not have role' do
# 
#       let(:role) { :coach }
# 
#       it { should be_false }
# 
#     end
# 
#   end
# 
#   describe '#has_multiple_roles?' do
#     subject { user.has_multiple_roles? }
# 
#     [:overlord, :captain, :vetter, :non_profit, :superhero_coach].each do |role|
#       context role do
#         let(:user) { FactoryGirl.create role }
#         it { should be_true }
#       end
#     end
# 
#     [:sidekick].each do |role|
#       context role do
#         let(:user) { FactoryGirl.create role }
#         it { should be_false }
#       end
#     end
#   end
# 
#   describe '#vetter?' do
#     let(:user) { FactoryGirl.build :user }
#     subject { user.vetter? }
# 
#     context 'user is not a vetter' do
#       it { should be_false }
#     end
# 
#     context 'user is in random groups' do
#       before :each do
#         user.groups << FactoryGirl.create(:non_profit_group)
#       end
# 
#       it { should be_false }
#     end
# 
#     context 'user is in a vetting group' do
#       before :each do
#         user.groups << FactoryGirl.create(:vetter_group)
#       end
# 
#       it { should be_true }
#     end
#   end
# 
#   describe '#non_profit?' do
#     let(:user) { FactoryGirl.build :user }
#     subject { user.non_profit? }
# 
#     context 'user is not a non-profit user' do
#       it { should be_false }
#     end
# 
#     context 'user is in random groups' do
#       before :each do
#         user.groups << FactoryGirl.create(:vetter_group)
#       end
# 
#       it { should be_false }
#     end
# 
#     context 'user is in a non-profit group' do
#       before :each do
#         user.groups << FactoryGirl.create(:non_profit_group)
#       end
# 
#       it { should be_true }
#     end
#   end
# 
#   describe '#set_random_password' do
#     subject { User.new.tap(&:set_random_password).password }
# 
#     it { should be_present }
#     it { should_not == User.new.tap(&:set_random_password).password }
#   end
# 
#   describe '#invitation_pending?' do
#     subject { User.new }
# 
#     context 'not invited' do
#       it { should_not have_invitation_pending }
#     end
# 
#     context 'invited' do
#       before :each do
#         subject.invited_by = FactoryGirl.create(:user)
#       end
# 
#       context 'invitation accepted' do
#         before :each do
#           subject.invitation_accepted_at = 2.minutes.ago
#         end
# 
#         it { should_not have_invitation_pending }
#       end
# 
#       context 'invitation not accepted' do
#         it { should have_invitation_pending }
#       end
#     end
#   end
# 
#   describe '#complete_registration!' do
# 
#     let(:user) { FactoryGirl.create(:incomplete_user) }
# 
#     subject { user.complete_registration! }
# 
#     specify { expect{ subject }.to change(user, :registered).to true }
# 
#   end
# 
#   describe "#choose_avatar" do
#     let(:user) { FactoryGirl.create :user, avatar: File.open(file_path, "rb") }
#     let(:file_path) { "#{Rails.root}/spec/support/assets/kitty.jpg" }
#     let(:other_file_path) { "#{Rails.root}/spec/support/assets/other_kitty.jpg" }
# 
#     context "when avatar_choice is 'current'" do
#       before { user.update_attributes! avatar_choice: "current" }
#       specify { user.avatar.filename.should == File.basename(file_path) }
#     end
# 
#     context "when avatar_choice is 'upload'" do
#       before { user.update_attributes! avatar_choice: "upload", avatar: File.open(other_file_path, "rb") }
#       specify { user.avatar.filename.should == File.basename(other_file_path) }
#     end
# 
#     context "when avatar_choice is 'twitter'" do
#       before do
#         user.should_receive(:twitter_image) { "http://twitter.com/images/other_kitty.jpg" }
#         FakeWeb.register_uri(:get, "http://twitter.com/images/other_kitty.jpg", body: File.open(other_file_path, "rb"))
#         user.update_attributes! avatar_choice: "twitter"
#       end
# 
#       specify { user.avatar.filename.should == File.basename(other_file_path) }
#     end
# 
#     context "when avatar_choice is 'facebook'" do
#       before do
#         user.should_receive(:facebook_image) { "http://facebook.com/images/kitty.jpg" }
#         FakeWeb.register_uri(:get, "http://facebook.com/images/kitty.jpg", body: File.open(file_path, "rb"))
#         user.update_attributes! avatar_choice: "facebook"
#       end
# 
#       specify { user.avatar.filename.should == File.basename(file_path) }
#     end
#   end
# 
#   describe '#meets_age_requirement_for?' do
#     let!(:user) { FactoryGirl.create :sidekick, dob: 15.years.ago }
#     subject { user.meets_age_requirement_for?(mission) }
# 
#     context 'valid age' do
#       let!(:mission) { FactoryGirl.create :sidekick_joinable_mission, minimum_age: 14 }
#       it { should be_true }
#     end
# 
#     context 'invalid age' do
#       let!(:mission) { FactoryGirl.create :sidekick_joinable_mission, minimum_age: 16 }
#       it { should be_false }
#     end
#   end
# 
#   describe '#member_of?' do
#     let!(:user) { FactoryGirl.create :sidekick }
#     let!(:group) { FactoryGirl.create :group }
# 
#     subject { user.member_of? group }
# 
#     context 'user is a member' do
#       before :each do
#         group.users << user
#       end
# 
#       it { should be_true }
#     end
# 
#     context 'user is not a member' do
#       it { should be_false }
#     end
#   end
# 
#   describe '#age' do
# 
#     subject { user.age }
# 
#     context 'user has a dob' do
# 
#       let!(:user) { FactoryGirl.create :user, dob: 5.years.ago }
# 
#       it { should == 5 }
# 
#     end
# 
#     context 'user has no dob' do
# 
#       let!(:user) { FactoryGirl.build :user, dob: nil }
# 
#       it { should == 0 }
# 
#     end
# 
#   end
# 
#   describe '#sidekick_checkins' do
#     let(:user) { FactoryGirl.create :user }
# 
#     subject { user.sidekick_checkins }
# 
#     it { should be_empty }
# 
#     context 'when user has joined missions but not checked in' do
#       let!(:sjm) { FactoryGirl.create :sidekick_joined_mission, user: user }
# 
#       it { should be_empty }
#     end
# 
#     context 'when user has joined and checked into a mission' do
#       let!(:sjm) { FactoryGirl.create :sidekick_joined_mission, user: user }
# 
#       before :each do
#         sjm.check_in_sidekick
#       end
# 
#       it { should include sjm }
#     end
#   end
# 
#   describe '#league_commander?' do
#     let(:user) { FactoryGirl.create :sidekick }
# 
#     context 'when user is a league commander' do
#       before :each do
#         user.leagues_commanded << FactoryGirl.create(:league)
#       end
# 
#       specify { user.should be_a_league_commander }
#     end
# 
#     context 'when user is a league member' do
#       before :each do
#         user.leagues << FactoryGirl.create(:league)
#       end
# 
#       specify { user.should_not be_a_league_commander }
#     end
#   end
# 
#   describe '#geocoding_required?' do
#     subject { user.geocoding_required? }
# 
#     context 'for a brand new user' do
#       let(:user) { User.new }
#       it { should be_false }
#     end
# 
#     context 'for a user with an incomplete profile' do
#       let(:user) { FactoryGirl.create :incomplete_user }
#       it { should be_false }
#     end
# 
#     context 'for a user completing their profile' do
#       let(:user) { FactoryGirl.create :incomplete_user }
# 
#       before :each do
#         # This is mimicking a user submitting the form to complete their profile - an existing incomplete user profile with now-unsaved changes
#         user.assign_attributes FactoryGirl.attributes_for(:sidekick).except(:beta_flag)
#       end
# 
#       it { should be_true }
#     end
# 
#     context 'for a user updating their DOB' do
#       let(:user) { FactoryGirl.create :sidekick }
# 
#       before :each do
#         user.dob = user.dob + 1.day
#       end
# 
#       it { should be_false }
#     end
# 
#     context 'for a user updating their address' do
#       let(:user) { FactoryGirl.create :sidekick }
# 
#       before :each do
#         user.street_address = '123 Fake St'
#       end
# 
#       it { should be_true }
#     end
#   end
# end
