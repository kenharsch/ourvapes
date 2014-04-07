class ConfigurationController < ApplicationController
	before_action :build_kit, only: [:index, :add, :remove, :show]

	def index
		@page = Constants::PAGE_CONFIG

		@add_or_change = "Add"
		@conf_objects = session[:kit_obj]

		check_compatibility
	end

	def add(add_type = params["add_type"], add_id = params["add_id"])
		session[:kit_obj] ||= KitSession.new
		session[:kit_obj].add_by_id(add_type,add_id)
		go_to_config
	end

	def remove(remove_item = params["remove"])
		session[:kit_obj] ||= KitSession.new
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

	def build_kit
		@partslist = Kit::HW_TYPES
=begin

		@kit_obj = Kit.new

		params["conf"] ||= {}
		error_flag = false;

		params["conf"].each do |part_type, part_id| #go through full array
			part_class = part_type.capitalize.constantize

			if part_class.exists?(part_id) #validate existence
				@kit_obj.update(part_type => part_class.find(part_id))
			else #could not find
				flash[:error] = "Invalid " + part_type + " selection"
				error_flag = true
			end
		end
		go_to_config if error_flag
		@conf_objects = @kit_obj.to_hash
=end
	end

	def check_compatibility
		@checker = ConfigChecker.new(session[:kit_obj])
	end

	def show
		go_to_config
	end
end
