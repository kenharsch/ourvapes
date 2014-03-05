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
end
