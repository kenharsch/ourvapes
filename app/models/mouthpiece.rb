class Mouthpiece < Product
	has_one :details, class_name: 'MouthpieceDet'
	default_scope joins(:details)
end
