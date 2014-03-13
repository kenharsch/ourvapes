class Wick < Product
	has_one :details, class_name: 'WickDet'
	#has_one :wick_dets, foreign_key: "details_id"
	#belongs_to :connector, through: :wick_dets
	delegate_details :resistance_in_ohm, to: :wick_dets
end
