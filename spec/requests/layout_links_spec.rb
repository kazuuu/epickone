require 'spec_helper'

describe "LayoutLinks" do
  it "should have a Home page at '/'" do
    get '/'
     # response.should have_selector("title:cotains('ePick One | About')")
   # response.body.should have_selector('title', :content => "ePick")
 #  response.should be_success
   end
  
end
