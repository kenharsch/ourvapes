class ProdSearch

	# returns a Sunspot::Search::StandardSearch object with our current search settings
	# query:: the search query as entered by the user (as string)
	# type:: the product type as upper case String, such as "Wick", or _nil_ for "all products"
	def self.full_text(query, type = nil, page = nil)
		search =  Product.search do

			# exclude kits because we are not handling them als products yet
			without(:type, "Kit")

			with(:type, type) unless type.nil?

			fulltext query do
				boost_fields :name => 2.0

				phrase_fields :name => 2.0
				phrase_fields :description => 2.0
				phrase_fields :manufacturer => 2.0
			end

			paginate :page => page, :per_page => 10
		end

		return search
	end
end