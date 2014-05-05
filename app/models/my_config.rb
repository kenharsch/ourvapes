class MyConfig
	def initialize
		@parts = {}
	end

	# type:: Product::TYPE_... or prod.type on a Product object
	def remove(type)
		@parts.delete(type)
	end

	# type:: Product::TYPE_... or prod.type on a Product object
	def part(type)
		return @parts[type]
	end

	def add_by_id(id)
		prod = Product.find(id)
		@parts[prod.type] = prod
	end

	def size
		return @parts.size
	end

	# use with a block expecting the two variables _type_ and _part_
	# type:: Product::TYPE_... or prod.type on a Product object
	# part:: a Product object
	def each_slot
		Kit::PART_TYPES.each {|type| yield(type, @parts[type])}
	end

	# returns an array of IDs representing the contained parts
	def ids
		result = []
		@parts.values.each {|prod| result << prod.id unless prod.nil?}
		return result
	end
end