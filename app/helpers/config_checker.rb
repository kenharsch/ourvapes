class ConfigChecker
	def set_parts(kit)
		@kit = kit
		@conflicts = []

		check(kit.mouthpiece, kit.tank)
		check(kit.tank, kit.wick)
		check(kit.tank, kit.button)
		check(kit.button, kit.battery)
		check(kit.button, kit.charger)
		check(kit.battery, kit.charger)
	end

	def conflicts?(prod_type = nil)
		@conflicts.each do |c|
			return true if [c.prod1.type, c.prod2.type].member?(prod_type)
		end

		false
	end

	def all_conflicts
		@conflicts
	end

	private

	def check(prod1, prod2)
		return prod1.nil? || prod2.nil?
		return if DBHelper.are_compat?(prod1, prod2)
		@conflicts << Conflict.new(prod1, prod2,
			"The #{prod1.type.downcase} #{prod1.name} and
			the #{prod2.type.downcase} #{prod2.name} are
			not compatible to each other.")
	end
end