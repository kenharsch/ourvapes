for i in 0..9
	wick = Wick.create(name: "Super Cool Wick #{i}", description: "Perfect for the user that is committed to e-cigs and wants a low cost way to replace their wick.")
	wick.resistance_in_ohm = Random.rand(0..11)
	wick.save
	battery = Battery.create(name: "Super Cool Battery #{i}", description: "Perfect for the user that is committed to e-cigs and wants a low cost way to replace their battery.")
	battery.voltage = Random.rand(100..201)
	battery.wattage = Random.rand(1..6)
	battery.save
	button = Button.create(name: "Super Cool Button #{i}", description: "Perfect for the user that is committed to e-cigs and wants a low cost way to replace their button.")
	cartridge = Cartridge.create(name: "Super Cool Cartridge #{i}", description: "Perfect for the user that is committed to e-cigs and wants a low cost way to replace their cartridge.")
	charger = Charger.create(name: "Super Cool Charger #{i}", description: "Perfect for the user that is committed to e-cigs and wants a low cost way to replace their charger.")
	mouthpiece = Mouthpiece.create(name: "Super Cool Mouthpiece #{i}", description: "Perfect for the user that is committed to e-cigs and wants a low cost way to replace their mouthpiece.")
	tank = Tank.create(name: "Super Cool Tank #{i}", description: "Perfect for the user that is committed to e-cigs and wants a low cost way to replace their Tank.")
	tank.volume_in_ml = Random.rand(10..51)
	tank.save
	juice = Juice.create(name: "Super Cool Juice #{i}", description: "Perfect for the user that is committed to e-cigs and wants a low cost way to replace their juice.")
	juice.nicotine_in_ml = Random.rand(10..21)
	juice.save
end