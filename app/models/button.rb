class Button < Product
	has_one :details, class_name: 'ButtonDet'
	has_one :connector, through: :button_dets
end
