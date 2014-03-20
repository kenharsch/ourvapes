class ProductListController < ApplicationController
	def list
		@add_or_change = "Add"
		@newprod = []

		Product.all.each do |prod|
			@newprod << [prod.id, prod.type, prod.name, prod.description, prod.details]
		end
		find_parts
	end

	def find_parts
		@partslist = ["mouthpiece","tank","wick","button","battery","charger"]
		@kit = {}
		
		params["kit"] ||= {}
		params["kit"].each do |part_type, part_id|
			model = part_type.capitalize.constantize
			if model.exists?(part_id)
				@kit[part_type] = model.find(part_id).name
			else
				flash[:notice] = "Invalid "+ part_type +" selection"
				params["kit"].delete(params["kit"].index(part_type))
			end
		end
	end
end
