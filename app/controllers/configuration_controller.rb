class ConfigurationController < ApplicationController

	def index
		@kit = params["kit"] || {}
	end

	
end
