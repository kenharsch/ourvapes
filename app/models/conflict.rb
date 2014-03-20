class Conflict
	attr_accessor :prod1, :prod2, :comment

	def initialize(prod1, prod2, comment)
		@prod1, @prod2, @comment = prod1, prod2, comment
	end
end