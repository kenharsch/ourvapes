class Wick < Product
	has_one :details, class_name: 'WickDet'
	delegate_details :resistance_in_ohm, :connector, to: :details
	default_scope {joins(:details)}
end