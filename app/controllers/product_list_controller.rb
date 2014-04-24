class ProductListController < ApplicationController

	def list
		@page = Constants::PAGE_PROD_LIST
		@add_or_change = "Add"

		@params_type = params[:type]

		if @params_type.blank?
			@title = "All Products"
		else
			@title = @params_type.pluralize
		end

		@query = params["query"]
		ProdSearch.full_text(@query, @params_type, params[:manus],
			params[:page]) do |results, manu_facets|
			@prods = results
			@manu_facets = manu_facets
		end

		unless @query.blank?
			@searched_in = @title
			@title = "Search Results"
		end
	end

	private
end
