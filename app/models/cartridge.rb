class Cartridge < Product
	has_one :details, class_name: 'CartridgeDet'
end
