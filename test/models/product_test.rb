require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	describe "handles compatibilities" do
		before do
			Product.clear_compat
		end

		it "says incompatible if two products were not set as compatible before" do
			p1 = Tank.create(name: "Super Tank 1")
			p2 = Wick.create(name: "Super Wick 1")

			Product.are_compat?(p1, p2).must_equal false
			Product.are_compat?(p2, p1).must_equal false
		end

		it "says compatible if two products were set as compatible before" do
			p1 = Mouthpiece.create(name: "Super MP 1")
			p2 = Button.create(name: "Super Button 1")

			Product.set_compat(p1, p2)

			Product.are_compat?(p1, p2).must_equal true
			Product.are_compat?(p2, p1).must_equal true
		end
	end
end