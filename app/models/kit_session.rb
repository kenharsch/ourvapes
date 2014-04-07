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
		@parts.each do |part|
			if !part.nil?
				count += 1
			end
		end
		return count
	end

	def tank
		return @parts["tank"]
	end

	def wick
		return @parts["wick"]
	end

	def mouthpiece
		return @parts["mouthpiece"]
	end

	def button
		return @parts["button"]
	end

	def battery
		return @parts["battery"]
	end

	def charger
		return @parts["charger"]
	end

end