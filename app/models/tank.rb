class Tank < Product
	delegate_details :volume_in_ml, :connector, to: 'TankDet'
end
