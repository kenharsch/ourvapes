class ProductListController < ApplicationController
	def list
		@page = Constants::PAGE_PROD_LIST

		@add_or_change = "Add"

		# limit to 20 items for faster loading during development;
		# exclude kits because we are not handling them als products yet
		@prods = Product.where.not(type: "Kit").take(20)

		@conf_objects = params["conf"] || {}
		#find_parts
	end

=begin
	def find_parts
		@partslist = ["mouthpiece","tank","wick","button","battery","charger"]
		@conf_objects = {}
		params["conf"] ||= {}

		params["conf"].each do |part_type, part_id|
			part_class = part_type.capitalize.constantize
			if part_class.exists?(part_id)
				@conf_objects[part_type] = part_class.find(part_id)
			else
				flash[:notice] = "Invalid " + part_type + " selection"
				remove(part_type)
			end
		end
	end


	def add(add_type = params["add_type"], add_id = params["add_id"])
		conf = params["conf"] || {}
		conf[add_type] = add_id
		go_to_config(conf)
	end

	def remove(remove_item = params["remove"])
		conf = params["conf"] || {}
		conf.delete(remove_item)
		go_to_config(conf)
	end
=end

end
