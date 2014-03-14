class Cartridge < Product
	has_one :details, class_name: 'CartridgeDet', dependent: :delete
	default_scope {joins(:details)}
end
