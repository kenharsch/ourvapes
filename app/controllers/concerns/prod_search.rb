class ProdSearch

	RESULTS_PER_PAGE = 10

	# use like the following:
	# ProdSearch.full_text("davide", "Tank", "", 2) {|results, manus| ...}
	# query:: the search query as entered by the user (as string), or _nil_ for "all products"
	# type:: the product type as upper case String, such as "Wick", or _nil_ for "all products"
	# page:: the current page of a paginated result set
	# manus:: a list of the selected manufacturers, an empty list, or _nill_
	def self.full_text(query, type, manus, page)
		search = Product.search do

			facet :manufacturer

			if type.blank?
				# exclude kits because we are not handling them as products yet
				without(:type, "Kit")
			else
				with(:type, type)
			end

			manus = [] if manus.blank?

			any_of do
				manus.each {|manu| with(:manufacturer, manu)}
			end

			fulltext query do
				boost_fields :name => 2.0

				phrase_fields :name => 2.0
				phrase_fields :description => 2.0
				phrase_fields :manufacturer => 2.0
			end

			paginate :page => page, :per_page => RESULTS_PER_PAGE
		end

		yield(search.results, sorted_facets(search, :manufacturer))
	end

	private

	def self.sorted_facets(search, facet_name)
		search.facet(facet_name).rows.sort {|left, right| left.value <=> right.value}
	end
end