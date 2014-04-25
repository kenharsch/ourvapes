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
		if params[:add_manu].present?
			add_manu
		elsif params[:remove_manu].present?
			remove_manu
		end
	end

	private

	def add_manu
		last_params = session[Constants::SESS_LAST_SEARCH_PARAMS]
		last_params[:manus] = [] unless last_params.has_key?(:manus)
		last_params[:manus] << params[:add_manu]
		redirect_to last_params
	end

	def remove_manu
		last_params = session[Constants::SESS_LAST_SEARCH_PARAMS]
		last_params[:manus].delete(params[:remove_manu])
		redirect_to last_params
	end

	def set_type
		# TODO
		# last_params = session[Constants::SESS_LAST_SEARCH_PARAMS]
		# last_params[:manus] ||= []
		# last_params[:manus] << params[:manu]
		# # redirect_to "/product_list/list?#{last_params.to_url}"
		# redirect_to "list?#{last_params.to_url}"
	end
end
