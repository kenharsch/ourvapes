class ApplicationController < ActionController::Base
	before_action :check_my_config

	include TheComments::ViewToken
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	private

	def check_my_config
		session[Constants::SESS_MY_CONFIG] ||= MyConfig.new
		my_config = session[Constants::SESS_MY_CONFIG]
		@my_config_label = "My Kit (#{my_config.size})"
	end
end
