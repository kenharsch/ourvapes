class Tank < Product
	has_one :details, class_name: 'TankDet', dependent: :delete
	delegate_details :volume_in_ml, :connector, to: :details
	default_scope {joins(:details)}
end
