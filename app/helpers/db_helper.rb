class DBHelper
	def self.are_compat?(prod1, prod2)
		prod1, prod2 = prod2, prod1 if prod2.id < prod1.id
		CompatPair.find_by prod1_id: prod1.id, prod2_id: prod2.id
	end

	def self.set_compat(prod1, prod2)
		prod1, prod2 = prod2, prod1 if prod2.id < prod1.id
		CompatPair.create(prod1: prod1, prod2: prod2)
	end

	def self.clear_compat
		CompatPair.delete_all
	end
end