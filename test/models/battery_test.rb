require 'test_helper'

class BatteryTest < ActiveSupport::TestCase
	describe "battery" do
		before do
			@bat_count_before = Product.count
			@det_count_before = BatteryDet.count
			@b = Battery.create
		end

		it "creates no details object if not needed" do
			@b.name = "Super Battery"
			@b.description = "really cool"
			Product.count.must_equal (@bat_count_before + 1)
			BatteryDet.count.must_equal (@det_count_before)
		end

		describe "interacts with associated details object" do

			before do
				@b.voltage = 12
				@b.save
			end

			it "creates and associates a details object if needed" do
				Product.count.must_equal (@bat_count_before + 1)
				BatteryDet.count.must_equal (@det_count_before + 1)
			end

			it "deletes associated details object if host object gets deleted" do
				@b.delete
				Product.count.must_equal @bat_count_before
				BatteryDet.count.must_equal @det_count_before
			end

			it "destroys associated details object if host object gets deleted" do
				@b.destroy
				Product.count.must_equal @bat_count_before
				BatteryDet.count.must_equal @det_count_before
			end

		end
	end
end
