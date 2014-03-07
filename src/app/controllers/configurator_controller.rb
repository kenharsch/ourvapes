class ConfiguratorController < ApplicationController
	def index

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
			Product.create(type:"wick",name:("wick" + wick.to_s))
		end
		(1..10).each do |tank|
			Product.create(type:"tank",name:("tank" + tank.to_s))
		end
	end

end
