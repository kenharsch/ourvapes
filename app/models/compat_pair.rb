class CompatPair < ActiveRecord::Base
	belongs_to :prod1, class_name: "Product", foreign_key: "prod1_id"
	belongs_to :prod2, class_name: "Product", foreign_key: "prod2_id"

	validates :prod1, :prod2, presence: true
	validates_uniqueness_of :prod1, :scope => [:prod2]
	validates_with ProdOrderValidator
end


class ProdOrderValidator < ActiveModel::Validator
	def validate(record)
		if record.prod1_id > record.prod2_id
			record.errors[:base] << "prod1 must have a lower id than prod2"
		end
	end
end