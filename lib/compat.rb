class Compat
	def self.are_compat?(prod1, prod2)
		prod1, prod2 = prod2, prod1 if prod2.id < prod1.id
		!CompatPair.find(prod1.id, prod2.id).nil?
	end

	def self.set_compat(prod1, prod2)
		prod1, prod2 = prod2, prod1 if prod2.id < prod1.id
		CompatPair.create(prod1: prod1, prod2: prod2)
	end
end