class KitDet < ActiveRecord::Base
	belongs_to :mouthpiece
	belongs_to :tank
	belongs_to :wick
	belongs_to :button
	belongs_to :battery
	belongs_to :charger
	belongs_to :cartridge
end
