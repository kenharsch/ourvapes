class Battery < Product
	delegate_details :voltage, :wattage, to: 'BatteryDet'
end
