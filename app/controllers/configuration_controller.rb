class ConfigurationController < ApplicationController

	def index
		@partslist = ["mouthpiece","tank","wick","button","battery","charger"]
		@add_or_change = "Add"

		@kit = {}
		params["kit"] ||= {}
		@partslist.each do |part|
			@kit[part] = params["kit"][part]
		end
	end

	def show

	end

	
end
