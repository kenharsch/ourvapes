class Charger < Product
	has_one :details, class_name: 'ChargerDet', dependent: :delete
	default_scope {joins(:details)}
end
