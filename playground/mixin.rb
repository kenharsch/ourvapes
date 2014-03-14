class ActiveRecord
end

module ProductMethods

# this should work in Rails and replace the whole rest of the module
#delegate :name, :description, :to => :product

def name
	@product.name
end

def name=(new_name)
	@product.name = new_name
end

def description
	@product.description
end

def description=(new_description)
	@product.description = new_description
end
end

class Product < ActiveRecord
	attr_accessor :name, :description
end

class Tank < ActiveRecord
	include ProductMethods
	attr_accessor :volume_in_ml

	def initialize
		@product = Product.new
	end
end

t = Tank.new
t.volume_in_ml = 12
t.name = "Tank 1"
t.description = "a really cool tank"

puts t.volume_in_ml
puts t.name
puts t.description