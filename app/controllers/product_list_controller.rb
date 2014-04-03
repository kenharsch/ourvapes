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