class ProductController < ApplicationController
  def show
  	@product = Product.find(params[:id])
    if !current_user.nil?
      @rating = Rating.where(product_id: @product.id, user_id: current_user.id).first 
      unless @rating 
        @rating = Rating.create(product_id: @product.id, user_id: current_user.id, score: 0)
      end
    else
      @rating = Rating.where(product_id: @product.id).first 
    end
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
