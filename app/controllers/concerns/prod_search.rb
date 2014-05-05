class ProdSearch

	attr_accessor :results, :manu_facets

	RESULTS_PER_PAGE = 10

	# use like the following:
	# ProdSearch.full_text("davide", nil, "Tank", nil,
	#	session[Constants::SESS_MY_CONFIG], 2) {|results, manus| ...}
	# query:: the search query as entered by the user (as string), or _nil_ for "all products"
	# compats:: list of numbers representing the selected compatibility filters or _nil_
	# (according to the constants in CompatPair like CompatPait::WORKS_WELL)
	# type:: the product type as upper case String, such as "Wick", or _nil_ for "all products"
	# manus:: a list of the selected manufacturers, an empty list, or _nill_
	# my_config:: the MyConfig object representing the current kit configuration
	# page:: the current page of a paginated result set
	def self.full_text(query, compats, type, manus, my_config, page)
		prod_search = ProdSearch.new

		compat_ids = compat_ids(compats, my_config)
		manus = [] if manus.nil?

		solr_search = create_search(query, type, manus, compat_ids, page)

		prod_search.results = solr_search.results

		search_all_manus = create_search(query, type, [], nil, nil)
		prod_search.manu_facets = sorted_facets(search_all_manus, :manufacturer)

		return prod_search
	end

	private

	def self.create_search(query, type, manus, compat_ids, page)
		return Product.search do

			facet :manufacturer

			with(:id, compat_ids) if compat_ids.present?

			if type.blank?
				# exclude kits because we are not handling them as products yet
				without(:type, "Kit")
			else
				with(:type, type)
			end

			with(:manufacturer, manus) unless manus.empty?

			fulltext query do
				boost_fields :name => 2.0

				phrase_fields :name => 2.0
				phrase_fields :description => 2.0
				phrase_fields :manufacturer => 2.0

				#TODO let products with better rating score better
			end

			paginate :page => page, :per_page => RESULTS_PER_PAGE
		end
	end

	def self.sorted_facets(search, facet_name)
		search.facet(facet_name).rows.sort {|left, right| left.value <=> right.value}
	end

	# compats:: list of numbers representing the selected compatibility filters or nil
	# according to the constants in CompatPair
	# returns:: _nil_ if compats is nil or empty, otherwise a list of IDs which represent products
	# which correspond to the, given compatibility filters given the current MyConfig
	def self.compat_ids(compats, my_config)
		# returns nil instead of an empty list in order to distinguish between the situation
		# where no compatibility filtering is selected (nil) and no compatible products exist
		# (empty list)
		return nil if compats.nil? || compats.empty? || my_config.nil?

		my_config_ids = my_config.ids

		return Product.select("products.id").distinct.
			joins("JOIN compat_pairs ON (products.id = prod1_id OR products.id = prod2_id)").
			where("(prod1_id IN (:my_config_ids) OR prod2_id IN (:my_config_ids))
				AND compatibility IN (:compats)
				AND products.id NOT IN (:my_config_ids)",
				my_config_ids: my_config_ids, compats: compats).
			pluck(:id)
	end
end