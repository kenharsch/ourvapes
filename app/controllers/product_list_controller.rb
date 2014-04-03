class ProductListController < ApplicationController

	def list
		@page = Constants::PAGE_PROD_LIST
		@add_or_change = "Add"

		@params_type = params["type"]
		type_filter = @params_type

		if type_filter.nil?
			@title = "All Products"
			@manus = Product.where.not(type: "Kit").select("manufacturer").distinct.order("manufacturer")
		else
			type_filter = type_filter.capitalize
			@title = type_filter.pluralize
			@manus = Product.where(type: type_filter).select("manufacturer").distinct.order("manufacturer")
		end

		@query = params["query"]
		@prods = ProdSearch.full_text(@query, type_filter, params[:page]).results

		unless @query.nil?
			@searched_in = @title
			@title = "Search Results"
		end

		@conf_objects = get_conf_objects
	end


	def get_conf_objects
		kit = Kit.new
		params["conf"] ||= {}
		errors = []

		params["conf"].each do |part_type, part_id| #go through full array
			part_class = part_type.capitalize.constantize

			if part_class.exists?(part_id) #validate existence
				kit.update(part_type => part_class.find(part_id))
			else #could not find
				errors << "invalid " + part_type + " selection"
			end
		end

		flash[:error] = errors.join("<br>") if errors.any?
		return kit.to_hash
	end

end
