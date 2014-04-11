require 'test_helper'

class ConfigurationControllerTest < ActionController::TestCase
	# TODO this line should actually be in the test_helper file instead of being required in
	# every controller test
	include Devise::TestHelpers

	test "should get index" do
		get :index
		assert_response :success
	end
end
