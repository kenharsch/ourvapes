class ConfigChecker
	# Returns a list of strings. Each entry states that a certain product pair is not compatible
	# (physically does not fit together).
	#
	# If there are no conflicts of this type this returns an empty list.
	attr_reader :pair_compat_conflicts

	# Returns a list of strings. Each entry states that a certain product pair, although compatible
	# (physically fit together), does not work well together.
	#
	# If there are no conflicts of this type this returns an empty list.
	attr_reader :pair_works_badly_conflicts


	def initialize(my_config)
		@pair_compat_conflicts = []
		@single_compat_conflicts = Hash.new { |hash, key| hash[key] = [] }

		@pair_works_badly_conflicts = []
		@single_works_badly_conflicts = Hash.new { |hash, key| hash[key] = [] }

		CompatPair::TYPE_PAIRS.each do |type1, type2|
			check(my_config.part(type1), my_config.part(type2))
		end
	end

	# Returns a list of strings according to the given product type. Each entry states that the
	# current product of the given type is not compatible (physically does not fit together) with
	# some other product in the current configuration.
	#
	# If there are no conflicts of this type this returns an empty list.
	#
	# prod_type:: Product::TYPE_... or prod.type on a Product object
	def compat_conflicts(prod_type)
		return @single_compat_conflicts[prod_type]
	end

	# Returns a list of strings according to the given product type. Each entry states that the
	# current product of the given type, although compatible to another product in the current
	# configuration, does not work well with the latter.
	#
	# If there are no conflicts of this type this returns an empty list.
	#
	# prod_type:: Product::TYPE_... or prod.type on a Product object
	def works_badly_conflicts(prod_type)
		return @single_works_badly_conflicts[prod_type]
	end


	private

	# Ignores the call if one of the two products is nil.
	#
	# If the given two products are not compatible (physically do not fit together) this causes
	# a corresponding entry in pair_compat_conflicts as well as two corresponding entries in
	# single_compat_conflicts. In particular no further conflict entries are done.
	#
	# Otherwise, if the two products are compatible but do not work well together, this causes
	# a corresponding entry in pair_works_badly_conflicts as well as two corresponding entries
	# in single_works_badly_conflicts.
	def check(prod1, prod2)
		return if prod1.nil? || prod2.nil?

		# TODO differentiate between these two
		bad_compatibilities = [CompatPair::UNKNOWN, CompatPair::INCOMPATIBLE]

		if bad_compatibilities.include? prod1.compat_with(prod2)
			@pair_compat_conflicts << "The #{prod1.type.downcase} #{prod1.name} and "\
			"the #{prod2.type.downcase} #{prod2.name} are not compatible at all. " \
			"Replace or remove one of them."

			@single_compat_conflicts[prod1.type] << "not compatible with "\
			"#{prod2.type.downcase} #{prod2.name} at all"

			@single_compat_conflicts[prod2.type] << "not compatible with "\
			"#{prod1.type.downcase} #{prod1.name} at all"

			return
		end

		if prod1.compat_with(prod2) == CompatPair::WORKS_BADLY
			@pair_works_badly_conflicts << "The #{prod1.type.downcase} #{prod1.name} and "\
			"the #{prod2.type.downcase} #{prod2.name} do not work well together. " \
			"Replace or remove one of them."

			@single_works_badly_conflicts[prod1.type] << "does not work well with "\
			"#{prod2.type.downcase} #{prod2.name}"

			@single_works_badly_conflicts[prod2.type] << "does not work well with "\
			"#{prod1.type.downcase} #{prod1.name}"
		end
	end
end