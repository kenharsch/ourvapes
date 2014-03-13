class Tank < Product
	has_one :details, class_name: 'TankDet'
	has_one :connector, through: :tank_dets
	delegate_details :volume_in_ml
end
