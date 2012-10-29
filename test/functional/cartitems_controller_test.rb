require 'test_helper'

class CartitemsControllerTest < ActionController::TestCase
  setup do
    @cartitem = cartitems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cartitems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cartitem" do
    assert_difference('Cartitem.count') do
      post :create, cartitem: { cart_id: @cartitem.cart_id, comment: @cartitem.comment, draw_id: @cartitem.draw_id, picked_number: @cartitem.picked_number, quantity: @cartitem.quantity, unit_price: @cartitem.unit_price, user_id: @cartitem.user_id }
    end

    assert_redirected_to cartitem_path(assigns(:cartitem))
  end

  test "should show cartitem" do
    get :show, id: @cartitem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cartitem
    assert_response :success
  end

  test "should update cartitem" do
    put :update, id: @cartitem, cartitem: { cart_id: @cartitem.cart_id, comment: @cartitem.comment, draw_id: @cartitem.draw_id, picked_number: @cartitem.picked_number, quantity: @cartitem.quantity, unit_price: @cartitem.unit_price, user_id: @cartitem.user_id }
    assert_redirected_to cartitem_path(assigns(:cartitem))
  end

  test "should destroy cartitem" do
    assert_difference('Cartitem.count', -1) do
      delete :destroy, id: @cartitem
    end

    assert_redirected_to cartitems_path
  end
end
