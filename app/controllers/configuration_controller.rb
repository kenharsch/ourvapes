class ConfigurationController < ApplicationController

	def index
		@partslist = ["mouthpiece","tank","wick","button","battery","charger"]
		@kit = {}
		params["kit"] ||= {}
		@partslist.each do |part|
			@kit[part] = params["kit"][part]
		end
	end

	def show

	end

	
end
