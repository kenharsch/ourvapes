class ProductListController < ApplicationController

	def list
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

		search = ProdSearch.full_text(@query, params[:compats], @type_filter, params[:manus],
			session[Constants::SESS_MY_CONFIG], params[:page])

		@prods = search.results
		@manu_facets = search.manu_facets
		@sel_manus = params[:manus] || []
		@compats = params[:compats] || []
	end

	def update
		last_params = session[Constants::SESS_LAST_SEARCH_PARAMS]

		[:add_compat, :remove_compat, :clear_compats,
			:add_manu, :remove_manu, :clear_manus,
			:set_type].each do |action|
			method(action).call(last_params) if params[action].present?
		end

		# after each search refinement the list should start at page 1
		last_params[:page] = 1

		redirect_to last_params
	end

	private

	def add_compat(last_params)
		last_params[:compats] = [] unless last_params.has_key?(:compats)
		last_params[:compats] << params[:add_compat]
	end

	def remove_compat(last_params)
		last_params[:compats].delete(params[:remove_compat])
	end

	def clear_compats(last_params)
		last_params.delete(:compats)
	end

	def add_manu(last_params)
		last_params[:manus] = [] unless last_params.has_key?(:manus)
		last_params[:manus] << params[:add_manu]
	end

	def remove_manu(last_params)
		last_params[:manus].delete(params[:remove_manu])
	end

	def clear_manus(last_params)
		last_params.delete(:manus)
	end

	def set_type(last_params)
		if params[:set_type] == "none"
			last_params.delete(:type)
		else
			last_params[:type] = params[:set_type]
		end
	end
end
