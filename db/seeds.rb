companies = ["Aro", "Smok Tech", "Oddy", "EHPro", "Nimbus", "Aspire", "Kanger", "AmeraVape", "Innokin iClear", "Tugboat", "AnyVape", "Vision", "Omega", "Patriot", "Kayfun"]
colors = ["Black", "Grey", "Stainless Steel", "Red", "Green", "Mystic Blue", "Forest Green", "Blue", "White", "Pearl White", "Metalic Red", "Fire Red", "Orange", "Hyper Yellow", "Pitch Black", "Pink", "Silver", "Gunmetal"]
adjectives = ["Mini", "Large", "Flashy", "Twisted", "BDC", "RDX", "Time", "Cool", "Mod", "Pro", "Professional", "RDA", "Pyrex", "EVOD", "Dual", "Mega", "Micro", "Metal", "Super", "Power", "Vivi", "Victory", "Nova"]
juices = ["Juicy Pear", "Pineapple", "Apple", "Tangy Orange", "Orange", "Grape", "Amazing Grape", "Juicy Apple", "Pear", "Coconut", "Pina Colada", "Lightning Lemon", "Lemon", "Lime", "Smokin Orange", "Tasty Grape", "Kiwi", "Mango", "Juicy Mango", "Honey Melon", "Amazing Coke"]
wick_pic = ['wick1.png', 'wick2.png', 'wick3.png']
batt_pic = ['batt1.png', 'batt2.png', 'batt3.png']
button_pic = ['button1.png', 'button2.png', 'button3.png', 'button4.png', 'button5.png']
cart_pic = ['cart1.png', 'cart2.png', 'cart3.png']
charger_pic = ['charger1.png', 'charger2.png', 'charger3.png']
mouth_pic = ['mouth1.jpg', 'mouth2.jpg', 'mouth3.jpg', 'mouth4.jpg', 'mouth5.jpg']
tank_pic = ['tank1.png', 'tank2.png', 'tank3.png', 'tank4.png', 'tank5.png']
juice_pic = ['apple.png', 'banana.png', 'blueberry.png', 'cherry.png', 'coconut.png']
descr = ['Perfect for the user that is committed to e-cigs and wants a low cost way to replace their ',
		'Essential hardware for the vaping enthusiast. Compare this model with our competitors and you will that this is best ',
		'The latest in vaping technology can be in your hand today! Check out the revolutionary technology in our ']


for i in 0..16
	wick = Wick.create(name: companies.sample + " " + colors.sample + " " + adjectives.sample + " Wick", description: descr.sample + "Wick!")
	wick.resistance_in_ohm = Random.rand(0..11)
	wick.picture_path = wick_pic.sample
	wick.save
	battery = Battery.create(name: companies.sample + " " + colors.sample + " " + adjectives.sample + " Battery", description: descr.sample + "Battery!")
	battery.voltage = Random.rand(100..201)
	battery.wattage = Random.rand(1..6)
	battery.picture_path = batt_pic.sample
	battery.save
	button = Button.create(name: companies.sample + " " + colors.sample + " " + adjectives.sample + " Button", description: descr.sample + "Button!")
	button.picture_path = button_pic.sample
	button.save
	cartridge = Cartridge.create(name: companies.sample + " " + colors.sample + " " + adjectives.sample + " Cartridge", description: descr.sample + "Cartridge!")
	cartridge.picture_path = cart_pic.sample
	cartridge.save
	charger = Charger.create(name: companies.sample + " " + colors.sample + " " + adjectives.sample + " Charger", description: descr.sample + "Charger!")
	charger.picture_path = charger_pic.sample
	charger.save
	mouthpiece = Mouthpiece.create(name: companies.sample + " " + colors.sample + " " + adjectives.sample + " Mouthpiece", description: descr.sample + "Mouthpiece!")
	mouthpiece.picture_path = mouth_pic.sample
	mouthpiece.save
	tank = Tank.create(name: companies.sample + " " + colors.sample + " " + adjectives.sample + " Tank", description: descr.sample + "Tank!")
	tank.volume_in_ml = Random.rand(10..51)
	tank.picture_path = tank_pic.sample
	tank.save
end

for i in 0..31
	juice = Juice.create(name: companies.sample + " " + juices.sample + " Refill Juice", description: descr.sample + "Juice!")
	juice.nicotine_in_ml = Random.rand(10..21)
	juice.picture_path = juice_pic.sample
	juice.save
end

# make sure param i is i%7 == 1 as this starts on a Wick from how the seed data is structured above
def self.populate_test_compats(i)
	w = Wick.find(i)
	counter = i+1
	types = [Tank, Mouthpiece, Charger, Cartridge, Button, Battery]
	6.times do
		t = types.pop
		w.set_compat_with(t.find(counter), true)
		counter += 1
	end
end

populate_test_compats(1)
populate_test_compats(8)
populate_test_compats(15)