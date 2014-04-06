require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	describe "Product" do
		before do
			Product.clear_compat

			@p1 = Tank.create(name: "Super Tank 1")
			@p2 = Wick.create(name: "Super Wick 1")
		end

		describe "'compatible with' statement" do
			it "is UNKNOWN if two products were not set as compatible before" do
				@p1.compat_with(@p2).must_equal CompatPair::UNKNOWN
				@p2.compat_with(@p1).must_equal CompatPair::UNKNOWN
			end

			it "is WORKS_BADLY if two products were set as such before" do
				@p1.set_compat_with(@p2, CompatPair::WORKS_BADLY)

				@p1.compat_with(@p2).must_equal CompatPair::WORKS_BADLY
				@p2.compat_with(@p1).must_equal CompatPair::WORKS_BADLY
			end

			it "can be changed afterwads" do
				@p1.set_compat_with(@p2, CompatPair::WORKS_WELL)
				@p1.set_compat_with(@p2, CompatPair::UNKNOWN)

				@p1.compat_with(@p2).must_equal CompatPair::UNKNOWN
				@p2.compat_with(@p1).must_equal CompatPair::UNKNOWN
			end

			it "can be set to UNKNOWN right at the beginning" do
				@p1.set_compat_with(@p2, CompatPair::UNKNOWN)

				@p1.compat_with(@p2).must_equal CompatPair::UNKNOWN
				@p2.compat_with(@p1).must_equal CompatPair::UNKNOWN
			end
		end

		describe "'works well with' statement" do
			it "is false if the products are not compatible at all" do
				@p1.compat_with(@p2).wont_equal CompatPair::WORKS_WELL
				@p2.compat_with(@p1).wont_equal CompatPair::WORKS_WELL
			end

			it "is false if the products are compatible but not defined as 'working well'" do
				@p1.set_compat_with(@p2, CompatPair::WORKS_BADLY)

				@p1.compat_with(@p2).wont_equal CompatPair::WORKS_WELL
				@p2.compat_with(@p1).wont_equal CompatPair::WORKS_WELL
			end

			it "is true if the products are defined as 'working well'" do
				@p1.set_compat_with(@p2, CompatPair::WORKS_WELL)

				@p1.compat_with(@p2).must_equal CompatPair::WORKS_WELL
				@p2.compat_with(@p1).must_equal CompatPair::WORKS_WELL
			end

			it "can be changed afterwards" do
				@p1.set_compat_with(@p2, CompatPair::WORKS_WELL)
				@p1.set_compat_with(@p2, CompatPair::UNKNOWN)

				@p1.compat_with(@p2).must_equal CompatPair::UNKNOWN
				@p2.compat_with(@p1).must_equal CompatPair::UNKNOWN
			end
		end
	end
end