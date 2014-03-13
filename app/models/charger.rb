class Charger < Product
	has_one :details, class_name: 'ChargerDet'
end
