require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get draws" do
    get :draws
    assert_response :success
  end

end
