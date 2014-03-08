class ConfiguratorController < ApplicationController
	#before_action :generate, only: index end

	def index
		#self.generate
		@wobj = []
		Product.create!(name:"button01",type:"Button")

		Product.all.each do |prod|
		end
			 obj = Product.find(Product.last.id - 1)
			@wobj << obj
				nobj = Product.find(obj.id + 1)
			@wobj << nobj

		#drop_all
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
			obj = Wick.new(name:("wick" + wick.to_s),type:"Wick")
			obj.save
		end

		(1..10).each do |tank|
			obj = Tank.new(name:("tank" + tank.to_s),type:"Tank")
			obj.save
		end
	end
 
	def drop_all
		Product.all.each do |product|
			product.destroy
		end
	end

end
