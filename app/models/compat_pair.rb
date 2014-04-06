class CompatPair < ActiveRecord::Base
	UNKNOWN = 0
	INCOMPATIBLE = 1
	WORKS_BADLY = 2
	WORKS_WELL = 3

	belongs_to :prod1, class_name: "Product", foreign_key: "prod1_id"
	belongs_to :prod2, class_name: "Product", foreign_key: "prod2_id"

	validates :prod1, :prod2, :compatibility, presence: true
	validates_uniqueness_of :prod1, :scope => [:prod2]
	validate :prod_order_must_be_asc
	validate :compatibility_must_be_one_of_the_constants

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
end