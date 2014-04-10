class ProductController < ApplicationController
  def show
  	@product = Product.find(params[:id])
  	@conf_objects = {}
  end
end
