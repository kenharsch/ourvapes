class Charger < Product
	has_one :details, class_name: 'ChargerDet'
	default_scope joins(:details)
end
