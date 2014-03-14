class Kit < Product
	delegate_details :battery, :button, :cartridge, :charger, :mouthpiece, :tank, :wick, to: 'KitDet'
end
