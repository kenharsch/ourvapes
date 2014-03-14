class Mouthpiece < Product
	has_one :details, class_name: 'MouthpieceDet', dependent: :delete
	default_scope {joins(:details)}
end
