class ProdSearch

	# returns a Sunspot::Search::StandardSearch object with our current search settings
	# query:: the search query as entered by the user (as string)
	# type:: the product type as upper case String, such as "Wick", or _nil_ for "all products"
	# page:: the current page of a paginated result set
	def self.full_text(query, type = nil, page = nil)
		if Rails.env.production?
			return tmp_solr_replacement_search(query, type, page)
		else
			return solr_search(query, type, page)
		end
	end

	private

	RESULTS_PER_PAGE = 10

	def self.solr_search(query, type, page)
		search = Product.search do

			# exclude kits because we are not handling them as products yet
			without(:type, "Kit") if type.blank?

			with(:type, type) unless type.blank?

			fulltext query do
				boost_fields :name => 2.0

				phrase_fields :name => 2.0
				phrase_fields :description => 2.0
				phrase_fields :manufacturer => 2.0
			end

			paginate :page => page, :per_page => RESULTS_PER_PAGE
		end

		return search.results
	end

	def self.tmp_solr_replacement_search(query, type, page)
		if query.blank? && type.blank?
			results = Product.where.not(type: "Kit")
		elsif query.blank?
			results = Product.where(type: type)
		else
			# return an empty result set (allows pagination etc.)
			results = Product.where(type: 'not existing type')
		end

		return results.page(page).per(RESULTS_PER_PAGE)
	end
end