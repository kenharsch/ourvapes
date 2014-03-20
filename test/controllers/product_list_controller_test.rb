require "test_helper"

class ProductListControllerTest < ActionController::TestCase
  test "should get list" do
    get :list
    assert_response :success
  end

end
