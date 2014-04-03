class ProductListController < ApplicationController

	def list
		@page = Constants::PAGE_PROD_LIST
		@add_or_change = "Add"

		part_type_filter = params["type"]

		if part_type_filter.nil?
			@title = "All Products"
			@manus = Product.where.not(type: "Kit").select("manufacturer").distinct.order("manufacturer")
		else
			part_type_filter = part_type_filter.capitalize
			@title = part_type_filter.pluralize
			@manus = Product.where(type: part_type_filter).select("manufacturer").distinct.order("manufacturer")
		end

		@query = params["query"]
		@prods = ProdSearch.full_text(@query, part_type_filter, params[:page]).results

		@title = "Search Results" unless @query.nil?

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
