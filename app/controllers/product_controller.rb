class ProductController < ApplicationController

	def show
		@product = Product.find(params[:id])
	end

	def new
	end

	def create
	end

	def edit
	end

	def update
	end

	def delete
	end
end
