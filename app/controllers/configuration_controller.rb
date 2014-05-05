class ConfigurationController < ApplicationController
	def index
		@page = Constants::PAGE_CONFIG

		@add_or_change
		# TODO introduce session key constants
		# TODO use MY_CONFIG instead of :kit_obj
		@checker = ConfigChecker.new(session[Constants::SESS_MY_CONFIG])
		if !params[:ids].nil?
			session[Constants::SESS_MY_CONFIG] = MyConfig.new
			params[:ids].each do |id|
				session[Constants::SESS_MY_CONFIG].add_by_id(id.to_i)
			end
			go_to_config
		end
		@url = create_url
	end

	# TODO remove unused add_type
	# TODO figure out if the optional parameters are needed
	def add(add_type = params["add_type"], add_id = params["add_id"])
		session[Constants::SESS_MY_CONFIG].add_by_id(add_id)
		go_to_config
	end

	# TODO figure out if the optional parameter is needed
	def remove(remove_slot = params["remove"])
		session[Constants::SESS_MY_CONFIG].remove(remove_slot)
		go_to_config
	end

	def clear
		session[Constants::SESS_MY_CONFIG] = MyConfig.new
		go_to_config
	end

	def go_to_config
		redirect_to "/configuration"
	end

	def create_url
		url = "#{root_url}configuration?"
		# instead of using ...ids.to_query('ids'): creates '...[]=' instead of '%5B%5D='
		session[Constants::SESS_MY_CONFIG].ids.each {|id| url += "&ids[]=" + id.to_s}
		return url
	end
end
