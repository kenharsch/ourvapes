class Mouthpiece < Product
	has_one :details, class_name: 'MouthpieceDet'
end
