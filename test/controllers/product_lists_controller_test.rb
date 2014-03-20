require "test_helper"

class ProductListsControllerTest < ActionController::TestCase

  before do
    @product_list = product_lists(:one)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:product_lists)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('ProductList.count') do
      post :create, product_list: {  }
    end

    assert_redirected_to product_list_path(assigns(:product_list))
  end

  def test_show
    get :show, id: @product_list
    assert_response :success
  end

  def test_edit
    get :edit, id: @product_list
    assert_response :success
  end

  def test_update
    put :update, id: @product_list, product_list: {  }
    assert_redirected_to product_list_path(assigns(:product_list))
  end

  def test_destroy
    assert_difference('ProductList.count', -1) do
      delete :destroy, id: @product_list
    end

    assert_redirected_to product_lists_path
  end
end
