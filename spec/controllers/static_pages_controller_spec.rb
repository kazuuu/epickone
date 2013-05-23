require 'spec_helper'

describe StaticPagesController do
  describe "#url_options" do
     subject { controller.url_options }
     it { should have_key(:locale) }
  end

  describe "GET 'about'" do
    I18n.available_locales.each do |locale|
      context locale do
        before do
          get 'about', :locale => locale
        end

        it 'should be successful' do
          response.should be_success
        end

        # it 'should have right title' do
        #   get 'about'
        #   response.should have_selector("title", 
        #     :content => "ePickOne | About")
        # end # it
      end
  #    
  #    it 'should have a non-blank body' do
  #      get 'about'
  #      response.body.should_not =~ /<body>/\s*<\/body>/
  #    end # it
    end # I18n
  end # describe 2
end # describe 1


