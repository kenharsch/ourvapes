class Product 

	attr_accessor :name, :description, :rating, :rating_count, :picture

	def initialize(name, description)
		@name = name
		@description = description
	end

end