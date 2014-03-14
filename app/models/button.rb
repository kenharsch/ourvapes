class Button < Product
	has_one :details, class_name: 'ButtonDet', dependent: :delete
	delegate_details :connector, to: :details
	default_scope {joins(:details)}
end
