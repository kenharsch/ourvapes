require 'test_helper'

class BatteryTest < ActiveSupport::TestCase
	describe "battery" do
		before do
			@bat_count_before = Battery.count
			@det_count_before = BatteryDet.count
		end

		it "creates no BatteryDet object if not needed" do
			b = Battery.create
			b.name = "Super Battery"
			b.description = "really cool"
			Battery.count.must_equal (@bat_count_before + 1)
			BatteryDet.count.must_equal (@det_count_before)
		end

		it "creates and associates a BatteryDet object if needed" do
			b = Battery.first
			b.voltage = 12
			Battery.count.must_equal (@bat_count_before + 1)
			BatteryDet.count.must_equal (@det_count_before + 1)
		end

	end
end
