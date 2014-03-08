require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get configuration" do
    get :configuration
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

end
