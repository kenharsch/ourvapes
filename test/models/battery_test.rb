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

		it "stores common attributes in the products table" do
			@b.name = "Super Battery 14"
			@b.save
			id = @b.id
			b2 = Product.find(id)
			b2.name.must_equal "Super Battery 14"
		end

		it "stores individual attributes in a separate table" do
			@b.voltage = "22-44"
			@b.save
			details_id = @b.details.id

			details = BatteryDet.find(details_id)
			details.voltage.must_equal "22-44"
		end

		it "allows queries referring to individual attributes from the host class" do
			@b.voltage = "43-44"
			@b.save
			id = @b.id

			results = Battery.where("voltage = '43-44'")
			results.size.must_equal 1
			results.first.id.must_equal id
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
