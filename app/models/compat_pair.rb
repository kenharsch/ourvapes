class CompatPair < ActiveRecord::Base
	UNKNOWN = 0
	INCOMPATIBLE = 1
	WORKS_BADLY = 2
	WORKS_WELL = 3

	# bidirectional compatibility rules to check
	# this is the only instance of these rules, caution if changing
	# make sure that each key is used only once
	TYPE_PAIRS = {
		Product::TYPE_MOUTHPIECE => Product::TYPE_TANK,
		Product::TYPE_WICK => Product::TYPE_TANK,
		Product::TYPE_TANK => Product::TYPE_BUTTON,
		Product::TYPE_BUTTON => Product::TYPE_BATTERY,
		Product::TYPE_CHARGER => Product::TYPE_BUTTON,
		Product::TYPE_BATTERY => Product::TYPE_CHARGER
	}

	belongs_to :prod1, class_name: "Product", foreign_key: "prod1_id"
	belongs_to :prod2, class_name: "Product", foreign_key: "prod2_id"

	validates :prod1, :prod2, :compatibility, presence: true
	validates_uniqueness_of :prod1, :scope => [:prod2]
	validate :prod_order_must_be_asc
	validate :compatibility_must_be_one_of_the_constants
	validate :types_must_correspond_to_a_rule

	def prod_order_must_be_asc
		if prod1_id >= prod2_id
			errors.add(:base, "prod1 must have a lower id than prod2")
		end
	end

	def compatibility_must_be_one_of_the_constants
		if ![INCOMPATIBLE, WORKS_BADLY, WORKS_WELL].include? compatibility
			errors.add(:compatibility, "must be one of the CompatPair constants")
		end
	end

	def types_must_correspond_to_a_rule
		TYPE_PAIRS.each do |type1, type2|
			return if prod1.type == type1 && prod2.type == type2
			return if prod1.type == type2 && prod2.type == type1
		end
		errors.add(:base,
			"the two product types must correspond to a rule in TYPE_PAIRS")
	end
end