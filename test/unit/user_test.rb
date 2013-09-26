require 'test_helper'

class UserTest < ActiveSupport::TestCase


  # test "should create user" do
  #   assert_difference('User.count') do
  #     post :create, locale: 'pt-BR', user: { email: 'marcello@ebocao.com', first_name: 'marcello', phone_mobile: '989989898', password: 'virus' }
  #   end
  # 
  #   assert_redirected_to root_path
  # end

  [:first_name, :last_name, :email].each do |attr|
    test "must have a #{attr}" do
      a = User.new
      refute(a.valid?)
      refute(a.errors.on(attr).nil?)
    end
  end
end
