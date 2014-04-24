class ApplicationController < ActionController::Base
	before_action :ensure_my_config

	include TheComments::ViewToken
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	def ensure_my_config
		session[Constants::SESS_MY_CONFIG] ||= MyConfig.new
		my_config = session[Constants::SESS_MY_CONFIG]
		@my_config_label = "My Configuration (#{my_config.size})"
	end
end
