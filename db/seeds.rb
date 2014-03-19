companies = ["Aro", "Smok Tech", "Oddy", "EHPro", "Nimbus", "Aspire", "Kanger", "AmeraVape", "Innokin iClear", "Tugboat", "AnyVape", "Vision", "Omega", "Patriot", "Kayfun"]
colors = ["Black", "Grey", "Stainless Steel", "Red", "Green", "Mystic Blue", "Forest Green", "Blue", "White", "Pearl White", "Metalic Red", "Fire Red", "Orange", "Hyper Yellow", "Pitch Black", "Pink", "Silver", "Gunmetal"]
adjectives = ["Mini", "Large", "Flashy", "Twisted", "BDC", "RDX", "Time", "Cool", "Mod", "Pro", "Professional", "RDA", "Pyrex", "EVOD", "Dual", "Mega", "Micro", "Metal", "Super", "Power", "Vivi", "Victory", "Nova"]
juices = ["Juicy Pear", "Pineapple", "Apple", "Tangy Orange", "Orange", "Grape", "Amazing Grape", "Juicy Apple", "Pear", "Coconut", "Pina Colada", "Lightning Lemon", "Lemon", "Lime", "Smokin Orange", "Tasty Grape", "Kiwi", "Mango", "Juicy Mango", "Honey Melon", "Amazing Coke"]

for i in 0..16
	wick = Wick.create(name: companies.sample + " " + colors.sample + " " + adjectives.sample + " Wick", description: "Perfect for the user that is committed to e-cigs and wants a low cost way to replace their wick.")
	wick.resistance_in_ohm = Random.rand(0..11)
	wick.save
	battery = Battery.create(name: companies.sample + " " + colors.sample + " " + adjectives.sample + " Battery", description: "Perfect for the user that is committed to e-cigs and wants a low cost way to replace their battery.")
	battery.voltage = Random.rand(100..201)
	battery.wattage = Random.rand(1..6)
	battery.save
	button = Button.create(name: companies.sample + " " + colors.sample + " " + adjectives.sample + " Button", description: "Perfect for the user that is committed to e-cigs and wants a low cost way to replace their button.")
	cartridge = Cartridge.create(name: companies.sample + " " + colors.sample + " " + adjectives.sample + " Cartridge", description: "Perfect for the user that is committed to e-cigs and wants a low cost way to replace their cartridge.")
	charger = Charger.create(name: companies.sample + " " + colors.sample + " " + adjectives.sample + " Charger", description: "Perfect for the user that is committed to e-cigs and wants a low cost way to replace their charger.")
	mouthpiece = Mouthpiece.create(name: companies.sample + " " + colors.sample + " " + adjectives.sample + " Mouthpiece", description: "Perfect for the user that is committed to e-cigs and wants a low cost way to replace their mouthpiece.")
	tank = Tank.create(name: companies.sample + " " + colors.sample + " " + adjectives.sample + " Tank", description: "Perfect for the user that is committed to e-cigs and wants a low cost way to replace their Tank.")
	tank.volume_in_ml = Random.rand(10..51)
	tank.save
end

for i in 0..31
	juice = Juice.create(name: companies.sample + " " + juices.sample + " Refill Juice", description: "Perfect for the user that is committed to e-cigs and wants a low cost way to refill their juice.")
	juice.nicotine_in_ml = Random.rand(10..21)
	juice.save
end