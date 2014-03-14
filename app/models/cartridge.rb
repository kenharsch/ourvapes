class Cartridge < Product
	has_one :details, class_name: 'CartridgeDet'
	default_scope joins(:details)
end
