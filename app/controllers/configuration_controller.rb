class ConfigurationController < ApplicationController

	def initialize
		@partslist = ["mouthpiece","tank","wick","button","battery","charger"]
	end

	def index
		@kit = {}
		params["kit"] ||= {}
		@partslist.each do |part|
			@kit[part] = params["kit"][part]
		end
	end

	def show

	end

	
end
