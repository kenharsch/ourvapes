class ConfiguratorController < ApplicationController
	#before_action :generate, only: index end

	def index
		self.generate
		wick = Product.find(1)


		drop_all
	end

	def is_compatible(part)
		return true
	end

	def style(part)
		if is_compatible(part)
			return "background-color:#A1ED7E;"
		else
			return "background-color:#ED7E7E;"
		end
	end

	def show
		
	end

	def generate
		(1..10).each do |wick|
			Product.create(type:"wick",name:("wick" + wick.to_s),wick_id:wick.to_s)
		end

		(1..10).each do |tank|
			Product.create(type:"tank",name:("tank" + tank.to_s),tank_id:tank.to_s)
		end
	end
 
	def drop_all
		Product.all.each do |product|
			product.destroy
		end

	end

end
