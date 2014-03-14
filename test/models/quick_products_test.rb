require 'test_helper'

class QuickProductsTest < ActiveSupport::TestCase
	before do
		@now = Time.now
	end

	describe "products with individual attributes can store and retrieve them" do

		it "parts with a connector can store and retrieve it" do
			[Tank, Wick, Button].each do |cls|
				con_name = "Connector #{@now}"
				obj_name = "Part with connector #{@now}"
				con = Connector.new(name: con_name)
				obj = cls.create(name: obj_name, connector: con)

				id = obj.id

				db_obj = cls.find(id)
				db_obj.name.must_equal obj_name
				db_obj.connector.must_equal con
			end
		end

		it "can store nicotine in a Juice object" do
			nicotine_in_ml = 12
			obj = Juice.create
			obj.nicotine_in_ml = nicotine_in_ml
			obj.save

			id = obj.id

			db_obj	= Juice.find(id)
			db_obj.nicotine_in_ml.must_equal nicotine_in_ml
		end

		it "can store hardware parts in a kit" do
			mp_name = "Super MP #{@now}"
			tank_volume = 22
			mp = Mouthpiece.create(name: mp_name)
			tank = Tank.create(volume_in_ml: tank_volume)

			kit = Kit.new(mouthpiece: mp)
			kit.tank = tank
			kit.save

			id = kit.id

			db_kit = Kit.find(id)
			db_kit.mouthpiece.must_equal mp
			db_kit.tank.must_equal tank
		end
	end

	describe "all products can store and retrieve the common product attributes" do

		it "stores attributes in the db and gets them back if needed" do
			@all_prod_classes = [Battery, Button, Charger, Juice, Kit, Mouthpiece, Tank, Wick]
			@all_prod_classes.each do |cls|
				name = "Name #{@now}"
				description = "Descr #{@now}"
				picture_path = "PicPath #{@now}"

				obj = cls.new
				obj.name = name
				obj.description = description
				obj.picture_path = picture_path
				obj.save

				id = obj.id

				db_obj = cls.find(id)
				db_obj.name.must_equal name
				db_obj.description.must_equal description
				db_obj.picture_path.must_equal picture_path
			end
		end
	end
end
