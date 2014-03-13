class Wick < Product
	has_one :wick_det, class_name: 'WickDet'
	delegate_details :resistance_in_ohm, to: :wick_det
end