require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	describe "Product" do
		before do
			Product.clear_compat

			@p1 = Tank.create(name: "Super Tank 1")
			@p2 = Wick.create(name: "Super Wick 1")
		end

		describe "'compatible to' statement" do
			it "is false if two products were not set as compatible before" do
				@p1.compat_with?(@p2).must_equal false
				@p2.compat_with?(@p1).must_equal false
			end

			it "is true if two products were set as compatible before" do
				@p1.set_compat_with(@p2, true)

				@p1.compat_with?(@p2).must_equal true
				@p2.compat_with?(@p1).must_equal true
			end

			it "can be changed afterwads" do
				@p1.set_compat_with(@p2, true)
				@p1.set_compat_with(@p2, false)

				@p1.compat_with?(@p2).must_equal false
				@p2.compat_with?(@p1).must_equal false
			end

			it "can be set to 'false' right at the beginning" do
				@p1.set_compat_with(@p2, false)

				@p1.compat_with?(@p2).must_equal false
				@p2.compat_with?(@p1).must_equal false
			end
		end

		describe "'works well with' statement" do
			it "is false if the products are not compatible at all" do
				@p1.works_well_with?(@p2).must_equal false
				@p2.works_well_with?(@p1).must_equal false
			end

			it "is false if the products are compatible but not defined as 'working well'" do
				@p1.set_compat_with(@p2, true)

				@p1.works_well_with?(@p2).must_equal false
				@p2.works_well_with?(@p1).must_equal false
			end

			it "is true if the products are defined as 'working well'" do
				@p1.set_works_well_with(@p2, true)

				@p1.works_well_with?(@p2).must_equal true
				@p2.works_well_with?(@p1).must_equal true
			end

			it "can be changed afterwards" do
				@p1.set_works_well_with(@p2, true)
				@p1.set_works_well_with(@p2, false)

				@p1.works_well_with?(@p2).must_equal false
				@p2.works_well_with?(@p1).must_equal false
			end

			it "can be set to 'false' right at the beginning" do
				@p1.set_works_well_with(@p2, false)

				@p1.works_well_with?(@p2).must_equal false
				@p2.works_well_with?(@p1).must_equal false
			end

			it "subsums the 'compatible to' statement" do
				@p1.set_works_well_with(@p2, true)

				@p1.compat_with?(@p2).must_equal true
				@p2.compat_with?(@p1).must_equal true
			end
		end
	end
end