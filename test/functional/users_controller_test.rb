require 'test_helper'

class UsersControllerTest < ActionController::TestCase
   setup :activate_authlogic

   test "should get index" do
     get :index, locale: 'pt-BR'
     assert_response :success
     assert_not_nil assigns(:users)
   end

  test "should get new" do
    get :new, locale: 'pt-BR'
    assert_response :success
  end
    # 
    # 
    # test "should create user" do
    #   assert_difference('User.count') do
    #     post :create, locale: 'pt-BR', user: { email: 'marcello@ebocao.com', first_name: 'marcello', phone_mobile: '989989898', password: 'virus' }
    #   end
    # 
    #   assert_redirected_to root_path
    # end
  
  test "should show user" do
    user_login(users(:ben))
    get :show, locale: 'pt-BR', id: users(:ben)
    assert_response :success
  end

  # 
  # test "should get edit" do
  #   get :edit, id: @post
  #   assert_response :success
  # end
  # 
  # test "should update post" do
  #   put :update, id: @post, post: { body: @post.body, title: @post.title }
  #   assert_redirected_to post_path(assigns(:post))
  # end
  # 
  # test "should destroy post" do
  #   assert_difference('Post.count', -1) do
  #     delete :destroy, id: @post
  #   end
  # 
  #   assert_redirected_to posts_path
  # end
end
