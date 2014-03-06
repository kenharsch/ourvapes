class UserMock
	attr_reader :name, :email

	def initialize(id)
		@name = "Prename#{id} Surname#{id}"
		@email = "user#{id}@example.com"
	end
end

class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def show
		# comment this out once DB is set up
		#@user = User.find(params[:id])
		@user = UserMock.new(params[:id])
	end

	def create
		@user = User.new
		@user.name = "Evan"
		@user.email = "e@email.com"
		#@user.password = "qwer1234"
		#@user.password_confirmation = "qwer1234"
		#@user = User.new(params[:user])
		puts params[:user]
		
		

    	# Not the final implementation!
#		if @user.save
	# Handle a successful save.
#		else
			render 'new'
#		end
  	end
end
