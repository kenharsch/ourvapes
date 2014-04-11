require "test_helper"

class ProductListControllerTest < ActionController::TestCase
	# TODO this line should actually be in the test_helper file instead of being required in
	# every controller test
	include Devise::TestHelpers


	test "should get list" do
		get :list
		assert_response :success
	end
end
