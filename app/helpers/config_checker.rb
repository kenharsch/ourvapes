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

	def initialize(kit)
		@pair_compat_conflicts = []
		@single_compat_conflicts = Hash.new([])

		@pair_works_badly_conflicts = []
		@single_works_badly_conflicts = Hash.new([])

		check(kit.mouthpiece, kit.tank)
		check(kit.tank, kit.wick)
		check(kit.tank, kit.button)
		check(kit.button, kit.battery)
		check(kit.button, kit.charger)
		check(kit.battery, kit.charger)
	end

	# Returns a list of strings according to the given product type. Each entry states that the
	# current product of the given type is not compatible (physically does not fit together) with
	# some other product in the current configuration.
	#
	# If there are no conflicts of this type this returns an empty list.
	#
	# prod_type:: a symbol representing the product type of interest
	def compat_conflicts(prod_type)
		return single_compat_conflicts[prod_type]
	end

	# Returns a list of strings according to the given product type. Each entry states that the
	# current product of the given type, although compatible to another product in the current
	# configuration, does not work well with the latter.
	#
	# If there are no conflicts of this type this returns an empty list.
	#
	# prod_type:: a symbol representing the product type of interest
	def works_badly_conflicts(prod_type)
		return single_compat_conflicts[prod_type]
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

		if !prod1.compat_with?(prod2)
			@pair_compat_conflicts << "The #{prod1.type.downcase} #{prod1.name} and
			the #{prod2.type.downcase} #{prod2.name} are not compatible at all."

			@single_compat_conflicts[type_sym(prod1)] << "not compatible with
			#{prod2.type.downcase} #{prod2.name} at all"

			@single_compat_conflicts[type_sym(prod2)] << "not compatible with
			#{prod1.type.downcase} #{prod1.name} at all"

			return
		end

		if !prod1.works_well_with?(prod2)
			@pair_works_badly_conflicts << "The #{prod1.type.downcase} #{prod1.name} and
			the #{prod2.type.downcase} #{prod2.name} do not work well together."

			@single_works_badly_conflicts[type_sym(prod1)] << "does not work well with
			#{prod2.type.downcase} #{prod2.name}"

			@single_works_badly_conflicts[type_sym(prod2)] << "does not work well with
			#{prod1.type.downcase} #{prod2.name}"
		end
	end

	# returns the type of the given product as a symbol
	def type_sym(product)
		return prod1.type.downcase.to_sym
	end
end