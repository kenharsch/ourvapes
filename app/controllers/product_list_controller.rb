class ProductListController < ApplicationController

	def list
		@page = Constants::PAGE_PROD_LIST

		@add_or_change = "Add"

		@query = params["query"]

		if @query.nil?
			# limit to 20 items for faster loading during development;
			# exclude kits because we are not handling them als products yet
			@prods = Product.where.not(type: "Kit").take(20)
		else
			@prods = ProdSearch.full_text(@query).results
		end

		@conf_objects = params["conf"] || {}
	end
end