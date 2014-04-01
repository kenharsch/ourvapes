class ProductListController < ApplicationController
	def list
		@page = Constants::PAGE_PROD_LIST

		@add_or_change = "Add"

		# limit to 20 items for faster loading during development;
		# exclude kits because we are not handling them als products yet
		@prods = Product.where.not(type: "Kit").take(20)

		@conf_objects = params["conf"] || {}

		if params["type"].nil?
			@part_type = "Part"
			# limit to 20 items for faster loading during development;
			# exclude kits because we are not handling them als products yet
			@prods = Product.where.not(type: "Kit").take(20)
		else
			@part_type = params["type"].capitalize!
			@prods = Product.where(type: @part_type)
		end
	end
end
