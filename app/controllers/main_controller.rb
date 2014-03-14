class MainController < ApplicationController

  def configuration
  end

  def search
  	@products = []
  	(0..5).each do |x|
  		@products << Mouthpiece.new(name: "MP #{x}", description: "test description")
  		@products << Tank.new(name: "TANK #{x}", description: "test description")
  	end
  end
end
