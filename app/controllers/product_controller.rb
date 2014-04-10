class ProductController < ApplicationController
  def show
  	@product = Product.find(params[:id])
  	@conf_objects = {}
  	if Post.exists? params[:id]
  		@post = Post.find params[:id]
  	else
  		@post = Post.create 
  		@post.id = params[:id]
  	end
	@comments = @post.comments.with_state([:draft, :published])
  end
end
