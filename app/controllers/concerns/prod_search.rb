class ProdSearch

	attr_accessor :results, :manu_facets

	RESULTS_PER_PAGE = 10

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

			with(:id, compat_ids) unless compat_ids.nil?

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
	# returns:: _nil_ if my_config is nil or compats is nil or empty, otherwise a list of IDs which
	# 	represent products which correspond to the, given compatibility filters given the current
	# 	MyConfig
	def self.compat_ids(compats, my_config)
		# returns nil instead of an empty list in order to distinguish between the situation
		# where no compatibility filtering is selected (nil) and no compatible products exist
		# (empty list)
		return nil if compats.nil? || compats.empty? || my_config.nil?

		if my_config.size == 0
			if compats.member?(CompatPair::WORKS_WELL)
				# if there is nothing in MyConfig, all products "work well" with it
				return nil
			else
				# however if MyConfig is empty no produc does not "work well" with it
				return []
			end
		end

		relation = compat_id_relation(compats, my_config.ids, free_types(my_config))

		return relation.pluck(:id)
	end

	def self.free_types(my_config)
		free_types = Product::ALL_TYPES.clone

		CompatPair.rules do |type1, type2|
			free_types.delete(type1) if my_config.part(type2).present?
			free_types.delete(type2) if my_config.part(type1).present?
		end

		return free_types
	end

	def self.compat_id_relation(compats, my_config_ids, free_types)
		checked_types_ids = Product.select("products.id").
		joins("JOIN compat_pairs ON (products.id = prod1_id OR products.id = prod2_id)").
		where("(prod1_id IN (:my_config_ids) OR prod2_id IN (:my_config_ids))",
			my_config_ids: my_config_ids).
		group("products.id").
		having("MIN(compatibility) IN (?)", compats)

		relation = Product.select("id").
		where("id NOT IN (?) AND (type IN (?) OR id IN (?))",
			my_config_ids, free_types, checked_types_ids.pluck(:id))

		return relation
	end
end