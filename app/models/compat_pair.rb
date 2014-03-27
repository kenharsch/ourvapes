class CompatPair < ActiveRecord::Base
	belongs_to :prod1, class_name: "Product", foreign_key: "prod1_id"
	belongs_to :prod2, class_name: "Product", foreign_key: "prod2_id"

	validates :prod1, :prod2, presence: true
	validates_uniqueness_of :prod1, :scope => [:prod2]
	validate :prod_order_must_be_asc

	def prod_order_must_be_asc
		if prod1_id >= prod2_id
			errors.add(:base, "prod1 must have a lower id than prod2")
		end
	end
end