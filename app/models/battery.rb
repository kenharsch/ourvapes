class Battery < Product
	has_one :details, class_name: 'BatteryDet', dependent: :delete
	delegate_details :voltage, :wattage, to: :details
	default_scope {joins(:details)}
end
