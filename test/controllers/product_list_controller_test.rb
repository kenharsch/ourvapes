require "test_helper"

class ProductListControllerTest < ActionController::TestCase
	include Devise::TestHelpers
	test "should get list" do
		get :list
		assert_response :success
	end
end
