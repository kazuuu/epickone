require 'test_helper'

class DrawshipsControllerTest < ActionController::TestCase
  setup do
    @drawship = drawships(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:drawships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create drawship" do
    assert_difference('Drawship.count') do
      post :create, drawship: { draw_id: @drawship.draw_id, picked_number: @drawship.picked_number, user_id: @drawship.user_id }
    end

    assert_redirected_to drawship_path(assigns(:drawship))
  end

  test "should show drawship" do
    get :show, id: @drawship
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @drawship
    assert_response :success
  end

  test "should update drawship" do
    put :update, id: @drawship, drawship: { draw_id: @drawship.draw_id, picked_number: @drawship.picked_number, user_id: @drawship.user_id }
    assert_redirected_to drawship_path(assigns(:drawship))
  end

  test "should destroy drawship" do
    assert_difference('Drawship.count', -1) do
      delete :destroy, id: @drawship
    end

    assert_redirected_to drawships_path
  end
end
