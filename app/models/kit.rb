class Kit < Product
	delegate_details :battery, :button, :cartridge, :charger, :mouthpiece, :tank, :wick, to: 'KitDet'

	PART_TYPES = [
		Product::TYPE_MOUTHPIECE,
		Product::TYPE_TANK,
		Product::TYPE_WICK,
		Product::TYPE_BUTTON,
		Product::TYPE_BATTERY,
		Product::TYPE_CHARGER]
end
