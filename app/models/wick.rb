class Wick < Product
	delegate_details :resistance_in_ohm, :connector, to: 'WickDet'
end