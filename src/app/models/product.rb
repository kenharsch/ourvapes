class Product < ActiveRecord::Base
	validates :type, :presence => true
	validates :name, :presence => true
	after_initialize :init

	def init
		# Define the subclass_id (eg tank_id) as being one more than the previous
		# for new records, provided that there is a previous record
		subclass_id = (self.type.downcase + "_id").to_sym 
		if new_record?
			if self.class.count == 0
				self[subclass_id] = 0
			else
				self[subclass_id] = self.class.last[subclass_id] + 1
			end
		end
	end
end
