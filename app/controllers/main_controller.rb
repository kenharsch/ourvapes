class MainController < ApplicationController
  
  require_relative "elements/mouthpiece"
  require_relative "elements/tank"

  def configuration
  end

  def search
  	@products = []
  	(0..5).each do |x|
  		@products << Mouthpiece.new("MP #{x}", "test description")
  		@products << Tank.new("TANK #{x}", "test description")
  	end
  end
end
