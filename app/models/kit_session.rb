class KitSession
	attr_accessor :parts
	HW_TYPES = ["mouthpiece","tank","wick","button","battery","charger"]

	def initialize
		@parts = {}
		HW_TYPES.each do |part_type|
			@parts[part_type] = nil
		end
	end

	def to_url
		return {conf: @parts}.to_param.to_s
	end

	def remove(part_type)
		@parts[part_type] = nil
	end

	def add_by_id(part_type, id)
		@parts[part_type] = part_type.capitalize.constantize.find(id)
	end

	def size
		count = 0
		@parts.each do |type, part|
			if !part.blank?
				count += 1
			end
		end
		return count
	end

end