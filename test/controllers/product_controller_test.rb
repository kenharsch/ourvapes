require 'test_helper'

class ProductControllerTest < ActionController::TestCase
	# TODO this line should actually be in the test_helper file instead of being required in
	# every controller test
	include Devise::TestHelpers

	test "should get show" do
		w = Wick.create(name: "test name")
		get :show, id: w.id
		assert_response :success
	end

end
