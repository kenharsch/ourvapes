class ProductListController < ApplicationController

	def list
		@page = Constants::PAGE_PROD_LIST
		@add_or_change = "Add"

		@params_type = params["type"]
		type_filter = @params_type
		type_filter = nil if type_filter == ""

		if type_filter.nil?
			@title = "All Products"
			@manus = Product.where.not(type: "Kit").select("manufacturer").distinct.order("manufacturer")
		else
			type_filter = type_filter.capitalize
			@title = type_filter.pluralize
			@manus = Product.where(type: type_filter).select("manufacturer").distinct.order("manufacturer")
		end

		@query = params["query"]
		@prods = ProdSearch.full_text(@query, type_filter, params[:page])

		unless @query.nil?
			@searched_in = @title
			@title = "Search Results"
		end
	end
end
