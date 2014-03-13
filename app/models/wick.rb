class Wick < Product
	has_one :wick_details, class_name: 'WickDet'
	delegate_details :resistance_in_ohm, to: :wick_details
	default_scope joins(:wick_details)
end