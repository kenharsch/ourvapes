class Button < Product
	has_one :details, class_name: 'ButtonDetails'
end
