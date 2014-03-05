class UserMock
	attr_reader :name, :email

	def initialize(id)
		@name = "name of user #{id}"
		@email = "user#{id}@example.com"
	end
end

class UsersController < ApplicationController
	def new
	end

	def show
		# comment this out once DB is set up
		#@user = User.find(params[:id])
	 	@user = UserMock.new(1)
	end
end
