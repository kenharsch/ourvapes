class Button < Product
	has_one :details, class_name: 'ButtonDet'
	delegate_details :connector, to: :details
	default_scope {joins(:details)}
end
