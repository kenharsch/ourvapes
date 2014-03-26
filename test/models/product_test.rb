require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	describe "handles compatibilities" do
		before do
			Product.clear_compat
		end

		it "says incompatible if two products were not set as compatible before" do
			p1 = Tank.create(name: "Super Tank 1")
			p2 = Wick.create(name: "Super Wick 1")

			p1.compat_to?(p2).must_equal false
			p2.compat_to?(p1).must_equal false
		end

		it "says compatible if two products were set as compatible before" do
			p1 = Mouthpiece.create(name: "Super MP 1")
			p2 = Button.create(name: "Super Button 1")

			p1.set_compat_to(p2, true)

			p1.compat_to?(p2).must_equal true
			p2.compat_to?(p1).must_equal true
		end
	end

	describe "handles works-well statements" do
		it "does not work well if it is not compatible at all" do

		end

		it "does not work well if it is compatible but not defined as working well" do

		end

		it "does work well if it is is set as 'works well'" do

		end
	end
end