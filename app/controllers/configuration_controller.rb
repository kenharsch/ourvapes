class ConfigurationController < ApplicationController
	before_action :check_session_kit


	def index
		@page = Constants::PAGE_CONFIG

		@add_or_change = "Add"
		@conf_objects = session[:kit_obj]

		@checker = ConfigChecker.new(@conf_objects.parts)
	end

	def add(add_type = params["add_type"], add_id = params["add_id"])
		session[:kit_obj].add_by_id(add_type,add_id)
		go_to_config
	end

	def remove(remove_item = params["remove"])
		session[:kit_obj].remove(remove_item)
		go_to_config
	end

	def clear
		session[:kit_obj] = KitSession.new
		go_to_config
	end

	def go_to_config
		redirect_to "/configuration"
	end

	def check_session_kit
		session[:kit_obj] ||= KitSession.new
	end

end
