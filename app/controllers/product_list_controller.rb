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

		build_kit
	end


	def build_kit
		@partslist = Kit::HW_TYPES
		@kit_obj = Kit.new
		params["conf"] ||= {}
		error_flag = false;

		params["conf"].each do |part_type, part_id| #go through full array
			part_class = part_type.capitalize.constantize

			if part_class.exists?(part_id) #validate existence
				@kit_obj.update(part_type => part_class.find(part_id))
			else #could not find
				flash[:error] = "Invalid " + part_type + " selection"
				error_flag = true
			end
		end
		@conf_objects = @kit_obj.to_hash
	end

end