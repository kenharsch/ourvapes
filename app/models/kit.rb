class Kit < Product
	has_one :details, class_name: 'KitDet'
	has_one :mouthpiece, through: :kit_dets
	has_one :tank, through: :kit_dets
	has_one :wick, through: :kit_dets
	has_one :button, through: :kit_dets
	has_one :battery, through: :kit_dets
	has_one :charger, through: :kit_dets
	has_one :cartridge, through: :kit_dets
end
