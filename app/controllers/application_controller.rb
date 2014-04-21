class ApplicationController < ActionController::Base
	before_action :ensure_my_config

	include TheComments::ViewToken
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	def ensure_my_config
		session[:kit_obj] ||= MyConfig.new
	end
end
