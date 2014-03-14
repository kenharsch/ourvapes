require 'test_helper'

class ButtonTest < ActiveSupport::TestCase
	describe "button" do
		before do
			@but_count_before = Product.count
			@det_count_before = ButtonDet.count
			@b = Button.create
		end

		it "creates no details object if not needed" do
			@b.name = "Super Button"
			@b.description = "really cool"
			Product.count.must_equal (@but_count_before + 1)
			ButtonDet.count.must_equal (@det_count_before)
		end

		it "stores common attributes in the products table" do
			@b.name = "Super Button 14"
			@b.save
			id = @b.id
			b2 = Product.find(id)
			b2.name.must_equal "Super Button 14"
		end

		it "stores individual attributes in a separate table" do
			@b.connector = Connector.new(name: "Connector X1")
			@b.save
			details_id = @b.details.id

			details = ButtonDet.find(details_id)
			details.connector.name.must_equal "Connector X1"
		end

		it "allows queries referring to individual attributes from the host class" do
			@b.connector = Connector.new(name: "Connector X2")
			@b.save
			id = @b.id
			connector_id = @b.connector.id

			results = Button.where("connector_id = #{connector_id}")
			results.size.must_equal 1
			results.first.id.must_equal id
		end

		describe "interacts with associated details object" do

			before do
				@b.connector = Connector.new(name: "Connector X3")
				@b.save
			end

			it "creates and associates a details object if needed" do
				Product.count.must_equal (@but_count_before + 1)
				ButtonDet.count.must_equal (@det_count_before + 1)
			end

			it "deletes associated details object if host object gets deleted" do
				@b.delete
				Product.count.must_equal @but_count_before
				ButtonDet.count.must_equal @det_count_before
			end

			it "destroys associated details object if host object gets deleted" do
				@b.destroy
				Product.count.must_equal @but_count_before
				ButtonDet.count.must_equal @det_count_before
			end

		end
	end
end
