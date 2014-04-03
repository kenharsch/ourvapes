class ProductListController < ApplicationController
	def list
		@page = Constants::PAGE_PROD_LIST
		@add_or_change = "Add"
		# limit to 20 items for faster loading during development;
		# exclude kits because we are not handling them als products yet
		@conf_objects = params["conf"] || {}

		if params["type"].nil?
			@part_type = "Part"
			# limit to 20 items for faster loading during development;
			# exclude kits because we are not handling them als products yet
			@prods = Product.where.not(type: "Kit").page(params[:page]).per(10)
			@manus = Product.where.not(type: "Kit").select("manufacturer").distinct.order("manufacturer")

		else
			@part_type = params["type"]
			@prods = Product.where(type: @part_type.capitalize).page(params[:page]).per(10)
			@manus = Product.where(type: @part_type.capitalize).select("manufacturer").distinct.order("manufacturer")
		end
	end
end
