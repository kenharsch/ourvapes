class ProdSearch

	def self.full_text(query)
		search =  Product.search do
			fulltext query do
				boost_fields :name => 2.0
			end
		end

		return search
	end
end