class Kit < Product
	delegate_details :battery, :button, :cartridge, :charger, :mouthpiece, :tank, :wick, to: 'KitDet'

	HW_TYPES = ["mouthpiece","tank","wick","button","battery","charger"]


	def to_url
		return {conf: to_hash}.to_param.to_s
	end

	def to_hash
		hash = {}
		HW_TYPES.each do |part|
			this_part = send(part.to_sym)
			if !this_part.nil?
				hash[part] = this_part
			end
		end
		return hash
	end

	def remove(part_type)
		update(part_type => nil)
	end

	def add_by_id(part_type, id)
		update(part_type => part_type.capitalize.constantize.find(id))
	end

end
