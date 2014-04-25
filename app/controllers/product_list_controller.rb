class ProductListController < ApplicationController

	def list
		# binding.pry
		session[Constants::SESS_LAST_SEARCH_PARAMS] = params.clone

		@page = Constants::PAGE_PROD_LIST
		@add_or_change = "Add"

		@type_filter = params[:type]

		if @type_filter.blank?
			@title = "All Products"
		else
			@title = @type_filter.pluralize
		end

		@query = params[:query]

		unless @query.blank?
			@searched_in = @title
			@title = "Search Results"
		end

		search = ProdSearch.full_text(@query, @type_filter, params[:manus], params[:page])
		@prods = search.results
		@manu_facets = search.manu_facets
		@sel_manus = params[:manus] || []
	end

	def update
		last_params = session[Constants::SESS_LAST_SEARCH_PARAMS]

		[:add_manu, :remove_manu, :set_type].each do |action|
			method(action).call(last_params) if params[action].present?
		end

		redirect_to last_params
	end

	private

	def add_manu(last_params)
		last_params[:manus] = [] unless last_params.has_key?(:manus)
		last_params[:manus] << params[:add_manu]
	end

	def remove_manu(last_params)
		last_params[:manus].delete(params[:remove_manu])
	end

	def set_type(last_params)
		last_params[:type] = params[:set_type]
	end
end
