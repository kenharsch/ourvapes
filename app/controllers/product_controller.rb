class ProductController < ApplicationController
	def index
		@conf_objects = {}
		render layout: false
		prod = Product.find(100)
	end
end