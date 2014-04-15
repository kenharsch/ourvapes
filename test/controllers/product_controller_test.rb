require 'test_helper'

class ProductControllerTest < ActionController::TestCase
	# TODO this line should actually be in the test_helper file instead of being required in
	# every controller test
	include Devise::TestHelpers

	test "should get show" do
		u = User.create
		w = Wick.create(name: "test name")
		r = Rating.create(product_id: w.id, user_id: u.id, score: 0)
		get :show, id: w.id
		assert_response :success
	end

end
