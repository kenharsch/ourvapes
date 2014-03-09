require 'test_helper'

class Wick::ProductsControllerTest < ActionController::TestCase
  setup do
    @wick_product = wick_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wick_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wick_product" do
    assert_difference('Wick::Product.count') do
      post :create, wick_product: {  }
    end

    assert_redirected_to wick_product_path(assigns(:wick_product))
  end

  test "should show wick_product" do
    get :show, id: @wick_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wick_product
    assert_response :success
  end

  test "should update wick_product" do
    patch :update, id: @wick_product, wick_product: {  }
    assert_redirected_to wick_product_path(assigns(:wick_product))
  end

  test "should destroy wick_product" do
    assert_difference('Wick::Product.count', -1) do
      delete :destroy, id: @wick_product
    end

    assert_redirected_to wick_products_path
  end
end
