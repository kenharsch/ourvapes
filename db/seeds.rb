=begin
LOREM = 'Veniam admodum posidonium quo ad, et copiosae recusabo sea, at corrumpit voluptatibus vel. Modo congue ea has, his cu purto appetere. Ut nec affert docendi alienum, te erant mundi vix, vix ex novum officiis evertitur. Possit dissentiunt ea pro. In duo tantas viderer reprehendunt, eu diceret placerat mei.

Est fuisset inimicus adolescens et, tale adipisci adolescens eos an. Ei ius autem admodum, ex per omnes antiopam neglegentur. Et ridens appetere pri, pertinax percipitur mea in, doctus repudiandae te his. Imperdiet torquatos ei pri.

Per ei velit mazim incorrupte, vis fugit vidisse an, no mei oblique ornatus. Ea principes ullamcorper duo, id nec dicant vidisse voluptatibus, in laoreet docendi elaboraret vix. Ne nostrud maluisset persequeris ius. Sit nihil perpetua ei, eam commodo malorum corrumpit ex, nec te utamur adipisci.

Porro menandri torquatos eu qui, ius ea quaerendum concludaturque. No his atqui velit facilis. Sed et omnis repudiandae, quo et hinc munere principes, vocibus salutatus signiferumque an qui. Eu esse postulant his, ius in viris epicuri quaerendum, nusquam suscipit scripserit eu cum. Numquam utroque mediocritatem duo id.

Vis ut percipit electram forensibus, an expetendis liberavisse disputationi qui. Verterem salutatus id eum, diam abhorreant pro in. Vim melius blandit an, aeterno erroribus eam eu. Sed ludus electram repudiare ad, quo primis nostrum in. Accusam inciderint concludaturque sea ei.

Aeque inciderint his cu, ei saepe intellegam pri, putent quodsi quo at. Nec feugait molestiae voluptatibus cu, deleniti maluisset disputationi vel ad. Eos id facete scriptorem, postea facete causae no eam. Aliquip pericula mea ut, sit an omnium iriure latine, his et gubergren voluptatibus. An vim mediocrem consectetuer. Duo ne autem dicat facer.

In est minimum omittam abhorreant, eos in consul accumsan.'

companies = ["KangerTech", "Trident", "Innokin", "Tugboat", "AnyVape", "Vision", "Omega", "Patriot", "Aspire"]
colors = ["Black", "Grey", "Stainless Steel", "Red", "Green", "Mystic Blue", "Forest Green", "Blue", "White", "Pearl White", "Metalic Red", "Fire Red", "Orange", "Hyper Yellow", "Pitch Black", "Pink", "Silver", "Gunmetal"]
adjectives = ["Essential", "Mini", "Large", "Flashy", "Twisted", "BDC", "RDX", "Time", "Cool", "Mod", "Pro", "Professional", "RDA", "Pyrex", "EVOD", "Dual", "Mega", "Micro", "Metal", "Super", "Power", "Vivi", "Victory", "Nova"]
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
	'The latest in vaping technology can be in your hand today! Check out the revolutionary technology in our ', 'From the largest manufacturer of vaping supplies,',
	'The leader in vaping technology presents']

# avoids seeding duplicates
Product.destroy_all

for i in 0..16
	wick = Wick.create(name: colors.sample + " " + adjectives.sample + " Wick", description: descr.sample + "Wick!")
	wick.resistance_in_ohm = Random.rand(0..11)
	wick.picture_path = wick_pic.sample
	wick.save

	battery = Battery.create(name: colors.sample + " " + adjectives.sample + " Battery", description: descr.sample + "Battery!")
	battery.voltage = Random.rand(100..201)
	battery.wattage = Random.rand(1..6)
	battery.picture_path = batt_pic.sample
	battery.save

	button = Button.create(name: colors.sample + " " + adjectives.sample + " Button", description: descr.sample + "Button!")
	button.picture_path = button_pic.sample
	button.save

	cartridge = Cartridge.create(name: colors.sample + " " + adjectives.sample + " Cartridge", description: descr.sample + "Cartridge!")
	cartridge.picture_path = cart_pic.sample
	cartridge.save

	charger = Charger.create(name: colors.sample + " " + adjectives.sample + " Charger", description: descr.sample + "Charger!")
	charger.picture_path = charger_pic.sample
	charger.save

	mouthpiece = Mouthpiece.create(name: colors.sample + " " + adjectives.sample + " Mouthpiece", description: descr.sample + "Mouthpiece!")
	mouthpiece.picture_path = mouth_pic.sample
	mouthpiece.save

	tank = Tank.create(name: colors.sample + " " + adjectives.sample + " Tank", description: descr.sample + "Tank!")
	tank.volume_in_ml = Random.rand(10..51)
	tank.picture_path = tank_pic.sample
	tank.save
end


for i in 0..31
	juice = Juice.create(name: juices.sample + " Refill Juice", description: descr.sample + "Juice!")
	juice.nicotine_in_ml = Random.rand(10..21)
	juice.picture_path = juice_pic.sample
	juice.save
end

# make each wick compatible with the 6 next parts in the products table (sorted by id)
types = [Battery, Button, Cartridge, Charger, Mouthpiece, Tank]
Wick.all.each do |w|
	(0..5).each do |index|
		type = types[index]
		other_part = type.find(w.id + index + 1)
		w.set_compat_with(other_part, true)
	end
end

Product.all.each do |p|
	p.manufacturer = companies.sample
	p.price = (Random.rand(500...3500) / 100.0)
	p.description += " \n\n#{LOREM}"
	p.save

end
=end
tank = Tank.create(name: "Davide" + " Tank", description: "1. High Polish.
2. Unique Design: Tube Locking Systerm, All Parts Changeable (especially glass tube & drip tip)  No Glue used so you can change the pyrex glass tank if you break it or just want a new color.
3. BCC Technology: Bottom Coil changeable, No Burning, Pure Taste.
4. Top Quality Coil, Good Throat-hit.
5. Easy to Be Cleaned.
6. Compatiable with eGo Series Batteries,Mods.

Read more: http://www.viper-vape.com/products/anyvape-davide-glassomizer.html#ixzz2xlATnASC" + "Tank!")
	tank.volume_in_ml = 2.5
	tank.picture_path = 'AnyvapeDavide.png'
	tank.manufacturer = "Anyvape"
	tank.price = 14.95
	tank.save

tank = Tank.create(name: "Davide BDC Glassomizer" + " Tank", description: "This new glassomizer is brought to you by Anyvape. Viper Vape is proud to introduce the Anvape Davide BDC worlds first bottom dual coil glassomizer. If you want to blow some massive clouds than you cant pass up on this revolutional new bdc glassomizer.

The Anyvape Davide BDC Glassomizer is a new style of bottom coil clearomizer featuring dual heating elements to provide twice the vapor. It is constructed entirely of metal and pyrex glass. It comes pre-loaded with one dual coil head and also a extra back coil as well.

Compare this tank with a standard Bottom Coil Clearomizer (BCC) and you will be astonished by the difference in taste and performance.  The Bottom Dual Coil (BDC) design is a major upgrade when compared to similar single coil tanks not only because of the dual coils, but also because of the uniquely designed replaceable coil and airflow system.  It was designed differently to eliminate common issues such as an airy draw, gurgling, and leaking that users often experience with other BCC tanks.  It also works to eliminate outside influences on flavor to provide a true and pure taste experience.

Included in kit:

1 Pyrex glass davide, 2 BDC coils and 1 beauty ring/spacer 

How to Use your Anyvape Davide BDC:

To fill, turn the tank upside down and remove the threaded end cap.  Fill the outer portion of the tank (avoid getting e-liquid into the center airflow tube) and then screw the end cap back onto the tank tightly.  You can now turn it rightside up and check for leaks before using.
Gurgling or Leaking can occur if liquid gets into the center airflow tube.  To clear this liquid and improve performance remove the tank from the battery and blow through the mouthpiece into a paper towel. The excess liquid will come out of the threaded end of the device.  If this happens often you may need to check that all connections are screwed down tightly or replace the head and wick assembly with a new one.
The head and wick assembly will sometimes loosen itself when the threaed end cap is unscrewed.  Always check that it is pushed into the bottom cap tightly tightly before screwing the cap back on.  Not doing so could result in a leaking or non-working device.
You should never run the tank completely dry.  Doing so could result in a burnt or damaged wick and can cause leaking.  Refill the tank when the liquid level reaches approximately 1/3 full
The lifespan of replacement heads can vary quite a bit, but following the above instructions will maximize the lifespan of the coil. 
 
Another great benefit of the Davide BDC is that you can remove the ring and use regular BCC coils if you run out of BDC coils.

 

Replacement atomizer heads/coils can be found here



Read more: http://www.viper-vape.com/products/anyvape-davide-bdc-glassomizer.html#ixzz2xlIkbdd8" + "Tank!")
	tank.volume_in_ml = 2.5
	tank.picture_path = 'Anyvape_Davide_BDC3.png'
	tank.manufacturer = "Anyvape"
	tank.price = 16.99
	tank.save

tank = Tank.create(name: "Mini Davide" + " Tank", description: "New Anyvape Glassomizer Mini Davide

Please click here for full independent review of this product :  http://vapingguides.com/blog/breaking-news/mini-davide-glassomizer-review/

All parts are replaceable including glass tank, drip tip and heating coil - Please see photos

Glassomizer Kit Contents:

1 x Glassomizer

3 x  Davide Glassomizer Coil Head , one pre-installed (1.8, 2.2, 2.8 ohm)

1 x eGo battery adaptor

***Please note that the limited edition gold Davide's cost an additional $2.00

Anyvape Glassomizer Mini Davide Glassomizer Advantages:
1. Nice Appearance, High Polish.
2. Unique Design: Tube Locking System, All Parts Changeable (especially glass tube & drip tip) Economic, No Glue 
3. BCC Technology: Bottom Coil changeable, No Burning , Pure Taste.
4. Top Quality Coil, Good Throat-hit.
5. Easy to Be Cleaned.
6. Compatable with eGo Series Batteries,Mods.

Anyvape Glassomizer Mini Davide Specification:

Diameter	14.5mm
Length	74mm
Resistance	1.8, 2.2, 2.8ohms
Weight	90g
Capacity	1.5ml
Color	Many Colors
Material                         	Copper, Pyrex Glass



Read more: http://www.viper-vape.com/products/anyvape-glassomizer-mini-davide.html#ixzz2xlKdE300 " + "Tank!")
	tank.volume_in_ml = 1.5
	tank.picture_path = 'Anyvape_Mini_Davide.png'
	tank.manufacturer = "Anyvape"
	tank.price = 13.95
	tank.save

	tank = Tank.create(name: "AquaRBA (clone)" + " Tank", description: " The HCigar AQUA atomizer clone is known as the Kayfun’s predecessor. The AQUA clone combines some of the best atomizers out there with a degree of craftsmanship and engineering. The HCigar AQUA clone has a very unique design that incorporates a similar design to the Kayfun. Each HCigar AQUA clone has a laser etched serial number on it and on the front side it has AQUA laser etched. Each HCigar AQUA clone will come with a spare parts bag that has a strand of braided silica, extra O-Rings and a screw. The AQUA clone’s tank holds 1.8ML of juice. It also has an adjustable silver plated contact pin. The atomizer connection is 510 threaded and fits most mechanical mods.

HCigar AQUA Clone Features/Specifications

510 Thread Connection
Laser Engraved Logo’s
Individually Serialized
100% Stainless Steel Body
4-Channel Dual Coil Capability
Bottom Feed Tank Atomizer
Adjustable Atomizer Contact Pin
1.8 ML Capacity
21mm Diameter
Hcigar Embroidered Carrying Case
Warning To Consumer:

Rebuildable atomizers are intended for advanced users, rebuildable atomizers should NOT be used with anything other than IMR batteries and are NOT intended for users who have no multimeter or knowledge of how to use a meter. Rebuildable atomizers cannot safely be used by inexperienced users or users who do not have basic knowledge of electronics.


1. Wicks and coils MUST be tested before use, if not tested they could harm the user.

2. Rebuildable Atomizers are intended to be used on Mechanical Mods only.

3. Rebuildable Atomizers WILL destroy electronic devices if coils and wicks are not built correctly.

4. By purchasing this product you certify that you meet the requirements above. You also agree to hold harmless Viper Vape Inc for any improper use of this product.

 



Read more: http://www.viper-vape.com/products/aqua-rba-clone.html#ixzz2xlLyNoW9" + "Tank!")
	tank.volume_in_ml = 1.8
	tank.picture_path = 'AquaRBAClone.png'
	tank.manufacturer = "Hcigar"
	tank.price = 49.99
	tank.save

	tank = Tank.create(name: "Aspire CE5-S BDC" + " Tank", description: "Aspire CE5-S BDC 

The Aspire CE5-S BDCC (Bottom Dual Coil Changeable) Clearomizer is the newest generation of clearomizers, featuring BDCC (Bottom Dual Coil Changeable) technology. This new generation clearomzier has a very humanistic design and gives the users the most enjoyable vaping experience. If you want to blow some massive clouds than you cant pass up on this revolutional new bdc clearomizer.The CE-S Clearomizer is a new style of bottom coil clearomizer featuring dual heating elements to provide twice the vapor. It comes pre-loaded with a 1.8ohm dual coil head. 

Compare this tank with a standard Bottom Coil Clearomizer (BCC) and you will be astonished by the difference in taste and performance. The Bottom Dual Coil (BDC) design is a major upgrade when compared to similar single coil tanks not only because of the dual coils, but also because of the uniquely designed replaceable coil and airflow system. It was designed differently to eliminate common issues such as an airy draw, gurgling, and leaking that users often experience with other BCC tanks. It also works to eliminate outside influences on flavor to provide a true and pure taste experience.

Features: 

Tube with metal casing
Very easy to refill (1.8ml capacity)
No burning, no leaking
Huge vapor 
Pure and clean taste
More stable and reliable
eGo threading
How to Use your new BDC:

To fill, turn the tank upside down and remove the threaded end cap.  Fill the outer portion of the tank (avoid getting e-liquid into the center airflow tube) and then screw the end cap back onto the tank tightly.  You can now turn it rightside up and check for leaks before using.
Gurgling or Leaking can occur if liquid gets into the center airflow tube.  To clear this liquid and improve performance remove the tank from the battery and blow through the mouthpiece into a paper towel. The excess liquid will come out of the threaded end of the device.  If this happens often you may need to check that all connections are screwed down tightly or replace the head and wick assembly with a new one.
The head and wick assembly will sometimes loosen itself when the threaed end cap is unscrewed.  Always check that it is pushed into the bottom cap tightly tightly before screwing the cap back on.  Not doing so could result in a leaking or non-working device.
You should never run the tank completely dry.  Doing so could result in a burnt or damaged wick and can cause leaking.  Refill the tank when the liquid level reaches approximately 1/3 full
The lifespan of replacement heads can vary quite a bit, but following the above instructions will maximize the lifespan of the coil.
Replacement Heads/Coils can be found here


Read more: http://www.viper-vape.com/products/aspire-ce5-s-bdc.html#ixzz2xlMiCQJB " + "Tank!")
	tank.volume_in_ml = 1.8
	tank.picture_path = 'aspire_ce5s_blue.png'
	tank.manufacturer = "Aspire"
	tank.price = 7.99
	tank.save

	tank = Tank.create(name: "Nautilus" + " Tank", description: "ASPIRE NAUTILUS FIRST GLASSOMIZER WITH ADJUSTABLE AIR FLOW CONTROL
If you have any question why you should buy this amazing new device than check out this indepedent video

The Aspire Nautilus glassomizer has a revolutionary new design that consists of features based from vape enthusiasts who have provided feedback of what an ideal tank should be. Utilizing this information, the engineers have created a new tank that provides optimal performance and superior vaping functionality. This tank is really a work of art and holds about 5ml of eliquid (twice the amount of what protank holds) Updated bottom dual coil and dont forget the most important part which is the air flow control.

 Key Features:

Stainless Steel  !!!!
Adjustable Airflow Control !!!
Pyrex glass tube holds about 5ml !!!
BDC (Bottom Dual Coil) Technology
Elegant Modem Body Shape
Resistance of Aspire BDC:

1.6ohm  (3.3v-5.0v)
1.8ohm (3.3v-6.0v)
Aspire Nautilus Glassomizer Kit comes with:

1x Full Aspire Nautilus Tank (1.6ohm BDC coil pre-installed)
1x Extra Aspire Nautilus BDC coil at 1.8ohm
1x eGo cone
1x User Manual

Read more: http://www.viper-vape.com/products/aspire-nautilus.html#ixzz2xlNWyZAw " + "Tank!")
	tank.volume_in_ml = 5
	tank.picture_path = 'nautilus_2.png'
	tank.manufacturer = "Aspire"
	tank.price = 35.99
	tank.save

	tank = Tank.create(name: "Hypertank Pyrex Glass BCC" + " Tank", description: "Hypertank Pyrex Glass BCC only from Viper Vape - This is the new Vivi Nova style tank that is going to blow your mind with clouds of vapor and lots of flavor

If you loved your Vision Vivi Nova your going to love this tank twice as much. Picture your Vivi Nova made of durable pyrex glass and move the coil to the bottom of the tank for great hits every time and you have the Hypertank!   

Each HyperTank consists of a glass inner tank,an aluminium outer tank,a bottom changeable coil, a stainless steel top,a removable stainless steel base and a replaceable chrome 510 drip tip

The inner tank, which hold the ejuice directly, is made with the glass material Pyrex, which is compatible with various ejuice and makes your vapor healthier.

The aluminium outer tank is an inseparable cover above the inner tank and does not touch ejuice. The outer tank has 4 windows, so you can see the ejuice level through windows easily.

HyperTank has the same bottom coil heating system as Kanger Protank. 
 
When the bottom coil dies, you can keep the metal base and replace only the coil head.

HyperTank uses a separate chrome 510 drip tip. You can replace it with various drip tip for 510/901.

HyperTank has a regular 510 connector and can can work well on most eGo batteries or devices with eGo/510 threading.



Inner Tank Material: Pyrex
Inner Tank Color: Clear
Outer Tank Material: Aluminium
Driptip Color: Chrome
Top and Base Material: Stainless Steel
Tank Capactiy: 5ml


Each pack contains
1pc HyperTank 
2pc Coil - One coil head already pre-installed (resistance 1.8om)

Replacement Coils/Heads can be found here



Read more: http://www.viper-vape.com/products/hypertank-pyrex-glass-bcc.html#ixzz2xlOWWfem " + "Tank!")
	tank.volume_in_ml = 5
	tank.picture_path = 'HypertankPyrex.png'
	tank.manufacturer = "Viper Vape"
	tank.price = 17.99
	tank.save

	tank = Tank.create(name: "iClear 30 Dual Coil" + " Tank", description: "Innokin iClear 30 dual coil clearomizer: 

The iClear 30 utilizes a rotatable mouth piece with an innovative 360 degree rotating design. These mouth pieces are designed to swivel around, providing a more comfortable and enjoyable vape!The iClear 30 features dual coils and a easily replaceable atomizer head.Innokin iClear 30 is the first dual coil clearomizer with a replaceable atomizer head, making it very inexpensive to maintain, while providing huge amounts of vapor and flavor. Another great feature of the iClear 30 is the large 3ml chamber for holding liquid. This means vapers can vape longer between fills, uninterrupted. Resistance 2.0-2.2ohms


Features

1. Easy to disassemble 
2. Stainless steel clearomizer 
3. Replaceable atomizer head 
4. Rotatable mouth piece 
5. Replaceable Dual Coil 
6. Rebuildable 
7. Large capacity 
8. Hold 3ml juice 
9. Keep the liquid fresh and original

Replacement Coils/Heads can be found here



Read more: http://www.viper-vape.com/products/innokin-iclear-30-dual-coil.html#ixzz2xlPUXxEF " + "Tank!")
	tank.volume_in_ml = 3
	tank.picture_path = 'innokiniclear30b.png'
	tank.manufacturer = "Innokin"
	tank.price = 11.50
	tank.save

	tank = Tank.create(name: "iClear X.I Pyrex BDC" + " Tank", description: "Innokin iClear X.I Pyrex BDC

The Innokin iClear X.I is a dual coil clearomizer with a replaceable coil unit, making it very inexpensive to maintain, while providing huge amounts of vapor and flavor.
Another great feature of the iClear X.I is the large 3ml tube for holding e-liquid. This means vapers can vape longer between fills, uninterrupted.
Innokin iClear X.I is made of Pyrex Glass. So the tube is more durabe and clean to keep e-juices.

 

How to replace the coil

Empty the iClear X.I Tank

Unscrew the bottom base. 

Unscrew the old coil and replace a new one.

 

How to refill the iClear X.I 

 1. Turn upside down the cartomizer and screw off the bottom base firstly. 

2. Use the syringer or needle tip dropper to fill less than 3ml e-liquid against the inner wall. Try not to get e-Liquid in the center hole as it's used for air flow. 

3. Carefully screw on the connector, connect it with the battery and enjoy it.

 

How to remove your BDCC  from battery

Hold the bottom of the clear cartomizer when you separate it from battery. Please do not screw the cartomizer from the top or middle of the cartomizer or  the e-liquid will spill out of tank

 

Tips

When the unit does not perform well or stops working just replace the coil unit with a new one and now you have a brand new unit again. No need to replace entire unit just coil.



Read more: http://www.viper-vape.com/products/innokin-iclear-x-i-pyrex-bdc.html#ixzz2xlPzEfrt " + "Tank!")
	tank.volume_in_ml = 3
	tank.picture_path = 'iclearxi.png'
	tank.manufacturer = "Anyvape"
	tank.price = 24.90
	tank.save

	tank = Tank.create(name: "Aero Tank" + " Tank", description: "The Aerotank is the first Kanger Adjustable Air Flow bottom coil clearomizer!!


Kanger Aerotank Features:

Airflow control
Stainless steel 
Stronger base
Pyrex tank is replaceable
Glue Free: All parts are replaceable
Can be fitted with 510 Drip tip



Replaceable Atomizer Heads
Bottom Coil
Pyrex Glass Tank


Tips:

The metal tube in the center of this Clearomizer leads from the mouthpiece to the battery end. Avoid getting liquid in this tube when filling the Clearomizer. 
When unfastening the base (atomizer head) to refill the Clearomizer, the seals are temporarily broken and liquid will leak from the mouthpiece or escape into the center tube. Always wrap a cloth or piece of tissue around the mouthpiece when unfastening the base of the Clearomizer.
Gurgling noise or leaks: This is a sign that liquid has found its way into the metal tube in the center of the Clearomizer (and usually occurs after a refill). Ridding the center tube of liquid will resolve the issue. To do so without emptying the tank, remove the Clearomizer from the battery, wrap a cloth or tissue around the battery end of the Clearomizer and blow through the mouthpiece. 
The atomizer head of the Protank can unfasten when unscrewing the tube or base. Always secure the atomizer head before reinstalling the base of the Protank.
It is normal to find a small amount of liquid in the battery contact area when removing the Clearomizer or any atomizer. We recommend cleaning the battery before charging it.


When possible, keep the tank full and never below 1/3 full of eLiquid (topped off). This helps maintain the vacuum in the tank and prevent leaks.
Atomizer heads have an average lifespan between 10 to 20 days. When the atomizer head wears down, it may begin to leak. Replace the atomizer head with a new one if available.


Package Contents:
1 x Kanger aerotank (Pyrex tank, top cap, bottom cap and 510 base)
1 x 510 Drip tip
2 x Atomizer Heads



Read more: http://www.viper-vape.com/products/kanger-aerotank.html#ixzz2xlQgSMmZ " + "Tank!")
	tank.volume_in_ml = 3
	tank.picture_path = 'kangeraerotank.png'
	tank.manufacturer = "Kanger"
	tank.price = 24.99
	tank.save



tank = Tank.create(name: "Magoo C" + " Tank", description: "This is for pro vapers only who have experience with rebuildable atomizers!

ismoka Magoo-C (limited edition Gold Color)

Magoo-C is a brand new product from ismoka and it has been developed with some of the most flexible features. It has a window to see liquid level and its liquid volume and air inflow are adjustable. In addition, you can interchange different mouthpieces according to the length or replace the heating coil (single and dual) and entire atomizer head. Of course, the scalable positive pole contact will better adapt and protect the battery contacts, so you can use it safely without any fear.

This is a very high quality clone of the Ithaka. The Ithaka retails for over $200 normally, but you can get the same experience with the high quality Magoo from iSmoka.

Features:

1. Individual window of liquid level;
2. Adjustable liquid volume through the rotational mouthpiece;
3. Adjustable air flow through the rotational air regulating ring;
4. Replaceable mouthpiece.
5. Alternative heating coil (single and dual) which brings more DIY fun.
6. Scalable positive pole contact which better adapts and protects the battery contacts.

Components:
1× Mouthpiece Cover
1× Tube Cover
1× Mouthpiece
1× Clear Tube
1× Metal Tube
1× Atomizer Head (Part A, Part B)
1× Atomizer Base



Read more: http://www.viper-vape.com/products/ismoka-magoo-c-single-or-dual-coil.html#ixzz2xlTuKvuZ" + "Tank!")
	tank.volume_in_ml = 3
	tank.picture_path = 'ismoka_magooc.png'
	tank.manufacturer = "ismoka"
	tank.price = 49.99
	tank.save


wick = Wick.create(name: "Anyvape Davide BDC Replacement Coil 1.6" + " Wick", description: " " + "Wick!")
	wick.resistance_in_ohm = 1.6
	wick.picture_path = 'AnyvapeBDCcoil.png'
	wick.manufacturer = "AnyVape"
	wick.price = 2.75
	wick.set_compat_with(Tank.find(2), true)
	wick.set_works_well_with(Tank.find(2), true)
	wick.save

wick = Wick.create(name: "Anyvape Davide BDC Replacement Coil 1.8" + " Wick", description: " " + "Wick!")
	wick.resistance_in_ohm = 1.8
	wick.picture_path = 'AnyvapeBDCcoil.png'
	wick.manufacturer = "AnyVape"
	wick.price = 2.75
	wick.set_compat_with(Tank.find(2), true)
	wick.set_works_well_with(Tank.find(2), true)
	wick.save

wick = Wick.create(name: "Anyvape Davide BDC Replacement Coil 2.1" + " Wick", description: " " + "Wick!")
	wick.resistance_in_ohm = 2.1
	wick.picture_path = 'AnyvapeBDCcoil.png'
	wick.manufacturer = "AnyVape"
	wick.price = 2.75
	wick.set_compat_with(Tank.find(2), true)
	wick.set_works_well_with(Tank.find(2), true)
	wick.save

wick = Wick.create(name: "Anyvape Mini Davide Replacement Coil 1.5" + " Wick", description: " " + "Wick!")
	wick.resistance_in_ohm = 1.5
	wick.picture_path = 'AnyvapeBDCcoil.png'
	wick.manufacturer = "AnyVape"
	wick.price = 2.50
	wick.set_compat_with(Tank.find(3), true)
	wick.set_works_well_with(Tank.find(3), true)
	wick.save

wick = Wick.create(name: "Anyvape Mini Davide Replacement Coil 1.8" + " Wick", description: " " + "Wick!")
	wick.resistance_in_ohm = 1.8
	wick.picture_path = 'AnyvapeBDCcoil.png'
	wick.manufacturer = "AnyVape"
	wick.price = 2.50
	wick.set_compat_with(Tank.find(3), true)
	wick.set_works_well_with(Tank.find(3), true)
	wick.save

wick = Wick.create(name: "Innokin i30B Replacement Coil 1.5" + " Wick", description: " " + "Wick!")
	wick.resistance_in_ohm = 1.5
	wick.picture_path = 'iclear30b_coil.png'
	wick.manufacturer = "Innokin"
	wick.price = 2.99
	wick.set_compat_with(Tank.find(8), true)
	wick.set_works_well_with(Tank.find(8), true)
	wick.save

wick = Wick.create(name: "Innokin i30B Replacement Coil 1.8" + " Wick", description: " " + "Wick!")
	wick.resistance_in_ohm = 1.8
	wick.picture_path = 'iclear30b_coil.png'
	wick.manufacturer = "Innokin"
	wick.price = 2.99
	wick.set_compat_with(Tank.find(8), true)
	wick.set_works_well_with(Tank.find(8), true)
	wick.save

wick = Wick.create(name: "Innokin i30B Replacement Coil 2.1" + " Wick", description: " " + "Wick!")
	wick.resistance_in_ohm = 2.1
	wick.picture_path = 'iclear30b_coil.png'
	wick.manufacturer = "Innokin"
	wick.price = 2.99
	wick.set_compat_with(Tank.find(8), true)
	wick.set_works_well_with(Tank.find(8), true)
	wick.save

wick = Wick.create(name: "Kanger Aerotank BDC Replacement Coi" + " Wick", description: " " + "Wick!")
	wick.resistance_in_ohm = 2.1
	wick.picture_path = 'kanger_protank_3.jpeg'
	wick.manufacturer = "Kanger"
	wick.price = 2.75
	wick.set_compat_with(Tank.find(10), true)
	wick.set_works_well_with(Tank.find(10), true)
	wick.save

wick = Wick.create(name: "Aspire CE5-s BDC Replacement Coil 1.6" + " Wick", description: " " + "Wick!")
	wick.resistance_in_ohm = 1.6
	wick.picture_path = 'aspire_ce5s_blue_coil.png.png'
	wick.manufacturer = "Aspire"
	wick.price = 2.75
	wick.set_compat_with(Tank.find(5), true)
	wick.set_works_well_with(Tank.find(5), true)
	wick.save

button = Button.create(name: "Kanger E.V.O.D" + " Button", description: "It is the latest KangerTech EVOD 1000mAh manual battery. With 1000mAh capacity, you can vape for 8 hours or more! 

It comes with eGo thread, it is compatible with eGo series atomizer/cartomizer. It also comes with short-circuit protection and overcharge protection.

KangerTech EVOD 1000mAh manual battery comes with 5-click protection: Generally, the battery is shipped in the off position. In off position, the unit will not function even when pressing the button. To turn on battery, press manual button 5 times within 2 seconds. You will see white LED flash. To turn off battery, press manual button 5 times within 2 second as well, the white LED will flash!  5-click protection can protect the battery from being activated when you do not want or do not use it. No more firing in your pocket!

10 seconds cutoff time! White LED!

Read more: http://www.viper-vape.com/products/kanger-evod-battery-1000mah.html#ixzz2xlYwO5pS" + "Button!")
	button.picture_path = "KangerEVOD.png"
	button.manufacturer = "Kanger"
	button.price = 18.99
	button.set_compat_with(Tank.find(8), true)
	button.set_compat_with(Tank.find(2), true)
	button.set_compat_with(Tank.find(4), true)
	button.set_works_well_with(Tank.find(8), true)
	button.set_works_well_with(Tank.find(2), true)
	button.save

button = Button.create(name: "AnyMOD" + " Button", description: "The Anyvape Anymod is a combination of both a regulated and unregulated device. Sounds amazing - and it is true - the Anyvape AnyMOD will smartly take you to the unregulated setting menu (MOD) when used with an atomizer resistance lower than 1.8 ohm - you can then choose this mode by double clicking the button and voila! You are now using a mechnaical device - at that point the voltage indicator on the screen will display the battery voltage.

The Anyvape AnyMOD is the latest regulated Variable Voltage (VV) and Variable Wattage (VW) battery. Due to the electric current limitation of the control board, most regulated APV batteries have a limitation with very low resistance atomizers, which is why some unregulated (mechanical) battery have become popular. Unfortunately, unregulated APV batteries are often expensive and they lack (without a Kick) the ability to fine tune the battery output to the ideal condition for your eLiquid/atomizer combination - moreover, unregulated battery output varies depending on the battery charge which makes it even more difficult to achieve the ideal vaping experience over an extended period.

Features:
Beautiful LCD screen to operate the device - very similar to the eVic screen. No more 1980's LED screen like so many other devices.
The screen elegantly displays the resistance of the atomizer - the battery charge and either the voltage or wattage currently selected.
Regulated mod of operation (Variable Voltage & Variable Wattage) for the best vaping experience with any eLiquid/atomizer combination.
Variable voltage from 3 to 6 volts.
Variable Wattage from 3 to 18 watts!
Unregulated mod of operation (mechanical) when used with low resistance atomizers.
Visual Operating System (We have no indication yet that the OS will be upgradable using a computer - we are waiting for confirmation).
No usage data synchronization like the eVic (this is a good thing - the monitoring was a bit of a gimmick which folks did not use after the novelty effect was passed).
Safety: Output Short Circuit Protection - Output Open Circuit Protection - Overtime Working Protection - Low Voltage Protection - Device Temperature Monitoring.
Threading: 510 and eGo compatible
Its power bank function allows you to charge your iPhone, iPad, Android OS device, Smart phones, etc. When charging a phone the AnyMOD cannot be used to vape at the same time.
The single button interface is very easy to operate: 1 click to select the next value (hold the button to quickly scroll through values) - 2 clicks to select the value - 3 clicks to get in and out of the menu.
When on - simply double click to change the voltage or the wattage - no need to get into the menu for that! Very smartly done.
 


Read more: http://www.viper-vape.com/products/anyvape-anymod.html#ixzz2xlZRpz9H" + "Button!")
	button.picture_path = "anymod2.png"
	button.manufacturer = "Anyvape"
	button.price = 75.00
	button.set_compat_with(Tank.find(3), true)
	button.set_compat_with(Tank.find(2), true)
	button.set_compat_with(Tank.find(1), true)
	button.set_compat_with(Tank.find(8), true)
	button.set_compat_with(Tank.find(9), true)
	button.set_compat_with(Tank.find(10), true)
	button.set_works_well_with(Tank.find(8), true)
	button.set_works_well_with(Tank.find(9), true)
	button.set_works_well_with(Tank.find(10), true)
	button.save

button = Button.create(name: "itaste 134" + " Button", description: "Innokin, a leading electronic cigarette manufacturer renowned for innovation and quality, is proud to announce the launch of the iTaste 134.

The iTaste 134 is a striking variable wattage vaping device; unlike any other mods available in the electronic cigarette industry today.

Made from the very best metals, the iTaste 134 is 100 percent stainless steel and you will realize it is worth every cent when you hold it in your hand.

Designed for lovers of weapons grade reliability, the iTaste 134 is a solid stainless steel work of art. The iTaste 134 is modeled after the Gatling gun, the weapon that ended any opposition and changed the way wars were won. Available in both Chrome and Black, the 134 is almost threateningly beautiful.

The iTaste 134 replaces a traditional digital screen and plastic buttons with an extremely accurate and durable slider mechanism rotational wheel that precisely adjusts wattage. Designed for simplicity in function, the wheel eliminates the need to look at a display screen. Adjusting wattage on the 134 is like changing from semi-automatic to full auto; simply rotate the dial to the wattage you desire. No buttons...no screens...just a real solid machine.

The iTaste 134 delivers a superior vaping experience to vape everywhere and like its namesake, this cutting-edge machine will revolutionize the industry. The iTaste 134 is ready, are you?

Lock and Load!

Main Features:

Scale Display Wattage Scale display...wattage offers more intuitive control and more accurate performance

Variable Wattage: The wattage can be adjusted with the rotational wheel to 6.5W, 7W, 8W, 9W, 10W, 11W, 12W, and 12.5W
Use lower wattage for low-resistance (ohms) accessories and higher wattage for high-resistance (ohms) accessories

Battery Level Indicator:
The iTaste 134 battery capacity is displayed via green, yellow, and red LED lights. Green = Fully ChargedYellow = Half DischargedRed = Charge Needed

High compatibility 510 connector:
Will fit iClear10, iClear16, and iClear30 clearomizers, as well as standard 510 accessories

ON/OFF Battery Switch:Quickly clicking the power button three times will enable or disable the battery. Once enabled, holding down the button will activate the device.

This safety feature prevents the atomizer from turning on while it’s in your pocket or bag and prevents accidental changes to your settings.

10-Seconds Cutoff:
If the button is held down for 10 seconds or longer, the iTaste 134 will shut itself off until the button is released and pressed again.

Short Circuit Protection. Reverse Battery Protection Circuit.

Click here to view the Variable Voltage Power Chart



Read more: http://www.viper-vape.com/products/innokin-itaste-134.html#ixzz2xlZzqUSk" + "Button!")
	button.picture_path = "innokin_itaste_134.png"
	button.manufacturer = "Innokin "
	button.price = 145.99
	button.save

button = Button.create(name: "itaste VTR" + " Button", description: "iTaste VTR is solid variable wattage and voltage vaping device with detailed finish. It features a rotational wheel and a protective skeleton to hold the tank inside. The voltage and wattage can be adjusted with the rotational wheel; the screen displays voltage or wattage and offers intuitive control over settings leading to more accurate performance. *** Please note that the VTR does not come with a battery but can use any unprotected 18650

Read more: http://www.viper-vape.com/products/innokin-itaste-vtr.html#ixzz2xlaRS4f7" + "Button!")
	button.picture_path = "Innokin_vtr.png"
	button.manufacturer = "Innokin"
	button.price = 105.00
	button.set_compat_with(Tank.find(10), true)
	button.set_compat_with(Tank.find(4), true)
	button.set_compat_with(Tank.find(1), true)
	button.set_compat_with(Tank.find(8), true)
	button.set_compat_with(Tank.find(9), true)
	button.set_compat_with(Tank.find(10), true)
	button.set_works_well_with(Tank.find(8), true)
	button.set_works_well_with(Tank.find(9), true)
	button.set_works_well_with(Tank.find(10), true)
	button.save

button = Button.create(name: "eGo-C Twist" + " Button", description: "The Anyvape eGo-C Twist is a variable voltage battery. You can adjust the voltage from 3.2V to 4.8V. 
The Anyvape eGo-C Twist is made by the same manufacturer and with the same material as the Joyetech eGo-C Twist version. Its main improvement over the Joyetech is the bottom knob which is much easier to read and use. The Anyvape eGo-C Twist has the Anyvape Twist logo on the side (see pictures). 
Usage Comments:

To lock the battery, simply click the button 5 times rapidly. The LED will flash indicating that the battery is now locked.
To unlock, simply press the button 5 times rapidly again and the LED will confirm it is unlocked.
Features:

Overcharge protection.
Short Circuit Protection: When short circuit happens, the battery will shut down and not function again until short circuit is removed.
Safety Cutoff/Atomizer Protection: If you press the button for 8 seconds, the battery will stop until the next press.
Low Voltage Protection: When the battery voltage is lower than 3.2 V, the battery will shut down automatically.
5 click on / off button.
Threading: 510 and eGo compatible.
Variable Voltage: 3.2V to 4.8V.


Read more: http://www.viper-vape.com/products/anyvape-ego-c-twist-650mah.html#ixzz2xlbYagEP" + "Button!")
	button.picture_path = "anyvapeegotwist.png"
	button.manufacturer = "Anyvape"
	button.price = 21.99
	button.set_compat_with(Tank.find(3), true)
	button.set_compat_with(Tank.find(2), true)
	button.set_compat_with(Tank.find(1), true)
	button.set_compat_with(Tank.find(8), true)
	button.set_compat_with(Tank.find(9), true)
	button.set_compat_with(Tank.find(10), true)
	button.set_works_well_with(Tank.find(3), true)
	button.set_works_well_with(Tank.find(2), true)
	button.set_works_well_with(Tank.find(1), true)
	button.save

button = Button.create(name: "eGo-V V2 650mAh" + " Button", description: "eGo-V V2 650mAh
So you dont want the big bulky variable voltage mods on the market but you do want the ability to get the best flavor from your e-liquid by being able to adjust the voltage output on your battery. Then this is just what you need! This MID-SIZE highly advanced battery allows for VARIABLE VOLTAGE from 3.0-6.0 V, accurate to 0.1 V . Moreover ,the Li-polymer cell is the best, most reliable battery on the market.



Read more: http://www.viper-vape.com/products/ego-v-v2-650mah.html#ixzz2xlc3yQ9p " + "Button!")
	button.picture_path = "egov_v.png"
	button.manufacturer = "Anyvape"
	button.price = 28.99
	button.set_compat_with(Tank.find(3), true)
	button.set_compat_with(Tank.find(2), true)
	button.set_compat_with(Tank.find(1), true)
	button.set_compat_with(Tank.find(8), true)
	button.set_compat_with(Tank.find(9), true)
	button.set_compat_with(Tank.find(10), true)
	button.set_works_well_with(Tank.find(3), true)
	button.save

button = Button.create(name: "eVic" + " Button", description: "There is a serial number for every Joyetech branded eVic kit, which is checked the authenticity of the eVic for the customers.If the product you buy without serial number, please deny it. Any Joyetech branded eVic without serial number will not be provided
	warranty or after sale service, also it can't be upgraded eVic or MVR software later." + "Button!")
	button.picture_path = "joyetech2.png"
	button.manufacturer = "Joyetech"
	button.price = 103.95
	button.save

button = Button.create(name: "Mego-V VV" + " Button", description: "The Mego-V is a variable voltage battery and can be adjusted from 3.0-6.0 volts. Removable top ring so you can easily use ego threaded atomizers as well as 510 threaded atomizers. This battery is no longer than a 1000mah ego battery. Battery indicator shows remaning battery life on the LCD screen as well as displays your current voltage when you adjust up or down. 

Included:

900mah Variable Voltage battery , USB Cord , Gift Box and instruction booklet. 



Read more: http://www.viper-vape.com/products/mego-v-vv-battery-900mah.html#ixzz2xldFM8tm" + "Button!")
	button.picture_path = "megov1.png"
	button.manufacturer = "Smiss"
	button.price = 29.99
	button.set_compat_with(Tank.find(4), true)
	button.set_compat_with(Tank.find(5), true)
	button.set_compat_with(Tank.find(6), true)
	button.set_compat_with(Tank.find(7), true)
	button.set_compat_with(Tank.find(11), true)
	button.set_compat_with(Tank.find(9), true)
	button.set_works_well_with(Tank.find(4), true)
	button.set_works_well_with(Tank.find(11), true)
	button.set_works_well_with(Tank.find(6), true)
	button.set_works_well_with(Tank.find(5), true)
	button.save

button = Button.create(name: "Smoktech SID" + " Button", description: "The new SmokTech SID variable voltage or wattage mod is the latest in their revolutionary lineup of VV / VW mods. With the ability to adjust from 3V to 6V in .1 increments, or 3 to 15 watts in .5 increments. The simplified sleek design and the revolutionary OLED display makes it one of the easiest most stylish single button VV/ VW mod on the market.

The light weight aluminum design comes in 5 different colors. First a matte black, a cherry red, matte white, pink, or a metallic blue.

The revolutionary OLED display is similar technology found in smart phones, and large HD televisions. This will make for a clear easy to read display.

Holds a single 18650 flat top battery for all day vaping

With a max output of 4Amps and reverse polarity protection, makes this one of the safest mod on the market.

The S.I.D variable voltage mod unit allows you to change either the voltage or power output applied to your atomizer. This intelligent electronic device ensures that it will always deliver a consistent voltage or power so that you can get the best possible experience from your atomizer and fluid.

Included with SID : Head Unit and Body

Main Features

1)  Maximum output of 6 voltage
2)  Voltage adjustment from 3.0V to 6.0V in 0.1V increments.
3)  Maximum output of 15 watts
4)  Power adjustment from 3.0W to 15W in 0.5W increments
5)  Output current limited to 4A
6)  Built in OLED display showing menu, function and selection
7)  Powered by Lithium-lon 18650 rechargeable batery(not included)
8)  Reverse polarity protection
9)  Fits compatible atomizers with a 510 screw threading fitting( not included)

 

Voltage Mode

1. Voltage up - Increase Voltage
2. Voltage down - Decrease Voltage
3. Out ON/OFF - Turn ON/OFF device
4. Battery Voltage - Battery voltage check
5. LCD Display - Display change
    Resist - resistance
    Battery - battery voltage
    Voltage - current set up for voltage
6. LCD ON/OFF - LCD light ON/OFF
7. Wattage Voltage
    Wattage - wattage mode
    Voltage - voltage mode

Wattage Mode

1. Watt up - wattage up
2. Watt down- wattage down
3. Out ON/OFF - Turn ON/OFF the device
4.  Batte Voltage - Battery voltage check
5. LCD Display - Display change
    Resist - resistance
    Battery - battery voltage
    Voltage - current set up wattage
6. LCD ON/OFF - LCD light on/off
7. Wattage Voltage
    Wattage - wattage mode
    Voltage - voltage mode

 


Read more: http://www.viper-vape.com/products/smoktech-sid.html#ixzz2xldj9dLe" + "Button!")
	button.picture_path = "Smoktech_sid.png"
	button.manufacturer = "Smoktech"
	button.price = 49.99
	button.set_compat_with(Tank.find(4), true)
	button.set_compat_with(Tank.find(5), true)
	button.set_compat_with(Tank.find(6), true)
	button.set_compat_with(Tank.find(7), true)
	button.set_compat_with(Tank.find(11), true)
	button.set_compat_with(Tank.find(9), true)
	button.set_works_well_with(Tank.find(4), true)
	button.set_works_well_with(Tank.find(11), true)
	button.set_works_well_with(Tank.find(6), true)
	button.set_works_well_with(Tank.find(5), true)
	button.save

button = Button.create(name: "Smoktech VMax V2" + " Button", description: "An amazing mod with tons of built in features! Adjustable voltage for the perfect vape! It is the updated Vmax Variable Voltage Battery MOD V2 from Smoktech. Its output voltage can be adjusted from 3.0-6.0V volts in 0.1 volt increments. So VMax can work on most cartomizers or atomizers with 510 threading from 1.25ohm to 3.0ohm. VMAX PCB allows 5 Amperage output limit. Vmax has built-in three digit display, which allows you to visually adjust your voltage.

Read more: http://www.viper-vape.com/products/smoktech-vmax-v2.html#ixzz2xle7G7HM" + "Button!")
	button.picture_path = "vmax5.png"
	button.manufacturer = "Smoktech"
	button.price = 84.99
	button.set_compat_with(Tank.find(4), true)
	button.set_compat_with(Tank.find(5), true)
	button.set_compat_with(Tank.find(6), true)
	button.set_compat_with(Tank.find(7), true)
	button.set_compat_with(Tank.find(11), true)
	button.set_compat_with(Tank.find(9), true)
	button.set_works_well_with(Tank.find(4), true)
	button.set_works_well_with(Tank.find(11), true)
	button.set_works_well_with(Tank.find(6), true)
	button.set_works_well_with(Tank.find(5), true)
	button.save

button = Button.create(name: "Vision E-Fire 1000mAh Wood Spinner" + " Button", description: "Unique hand carved design on a wooden body. This is a variable voltage battery. Show your style and get one of these unique batteries while they last.
Standard 510/eGo thread. 1000mAh Capacity.There maybe some color differences since these are wood batteries. Limited edition so hurry and get yours today
Options A and C both are version 2. Option B is version 1.
 

 

5-Click protection: Generally, the battery is shipped in the off position. In off position, it will not function even when pressing the button. To turn on battery, press manual button 5 times within 2 seconds. You will see white LED flash. To turn off battery, press manual button 5 times within 2 second as well, the white LED will flash!  5-click protection can protect the battery from being activated when you do not want or do not use it. No more firing in your pocket!


Cut off time: If the button is pressed for 10 seconds, the battery will shutoff until the button is released.


Short Circuit Protection: When a short is detected, the battery will shutdown until the short is removed.


Low Voltage Protection: When the battery voltage is lower than 3.3v, the battery will shut down.


Over-Discharge Protection: The device will monitor the battery voltage and automatically turn off when the battery is discharged, preventing damage to the battery by overly depleting it. The LED will blink 5 times indicating that a charge is need.



Read more: http://www.viper-vape.com/products/vision-e-fire-1000mah-wood-spinner.html#ixzz2xleXnqRT" + "Button!")
	button.picture_path = "MB_Vision_X.Fire_E_Fire_1000mah_Wood_Spinner_Variable_Voltage.png"
	button.manufacturer = "Viper Vape "
	button.price = 54.99
	button.set_compat_with(Tank.find(3), true)
	button.set_compat_with(Tank.find(5), true)
	button.set_compat_with(Tank.find(6), true)
	button.set_works_well_with(Tank.find(3), true)
	button.set_works_well_with(Tank.find(5), true)
	button.save

battery = Battery.create(name: " IMR 14500" + " Battery", description: "AW IMR 14500 3.7v 700mAh Protected Button Top

Read more: http://www.viper-vape.com/products/aw-imr-14500-3-7v-700mah.html#ixzz2xljVUg9P" + "Battery!")
	battery.voltage = 3.7
	battery.wattage = 700
	battery.picture_path = 'aw__28994.1392842090.360.360.png'
	battery.manufacturer = "AW"
	battery.price = 9.50
	battery.set_compat_with(Button.find(30), true)
	battery.set_works_well_with(Button.find(30), true)
	battery.set_compat_with(Button.find(31), true)
	battery.set_works_well_with(Button.find(31), true)
	battery.save

battery = Battery.create(name: "IMR 18350" + " Battery", description: "AW IMR 18350 3.7v 700mAh protected button top battery

Read more: http://www.viper-vape.com/products/aw-imr-18350-3-7v-700mah.html#ixzz2xljQ4vXj" + "Battery!")
	battery.voltage = 3.7
	battery.wattage = 700
	battery.picture_path = 'aw350__37068.1388869064.360.360.png'
	battery.manufacturer = "AW"
	battery.price = 9.50
	battery.set_compat_with(Button.find(30), true)
	battery.set_works_well_with(Button.find(30), true)
	battery.set_compat_with(Button.find(31), true)
	battery.set_works_well_with(Button.find(31), true)
	battery.save

battery = Battery.create(name: "IMR 18490" + " Battery", description: "AW IMR 18490 3.7v 1100mAh Protected Button Top

Read more: http://www.viper-vape.com/products/aw-imr-18490-3-7v-1100mah.html#ixzz2xljIxzot" + "Battery!")
	battery.voltage = 3.7
	battery.wattage = 1100
	battery.picture_path = 'aw__46329.1389340974.360.360.jpg'
	battery.manufacturer = "AW"
	battery.price = 11.00
	battery.set_compat_with(Button.find(30), true)
	battery.set_works_well_with(Button.find(30), true)
	battery.set_compat_with(Button.find(31), true)
	battery.set_works_well_with(Button.find(31), true)
	battery.save

battery = Battery.create(name: "Efest 18650" + " Battery", description: "30 amp discharge

Model: Efest IMR 18650 V3 2100mAh

Size: 18650

Capacity: 2100mAh

Top: flat top

Bottom: non-proctected
Weight: 50g

Nominal Capacity: 2100mAh 

Nominal Voltage: 3.7v

Dishcarge temperature range: -10°C—60°C
Charge temperature range: 0°C—40°C
Storage: 1 year: -20°C—25°C
            3 months: -20°C—45°C

            1 month: -20°C—60°C



Read more: http://www.viper-vape.com/products/efest-18650-3-7v-li-mn-2100mah.html#ixzz2xljAsKXX" + "Battery!")
	battery.voltage = 3.7
	battery.wattage = 2100
	battery.picture_path = '20131226015069506950__70481.1396373090.360.360.jpg'
	battery.manufacturer = "Efest"
	battery.price = 10.50
	battery.set_compat_with(Button.find(30), true)
	battery.set_works_well_with(Button.find(30), true)
	battery.set_compat_with(Button.find(31), true)
	battery.set_works_well_with(Button.find(31), true)
	battery.save

battery = Battery.create(name: "Efest 18350" + " Battery", description: "18350, 3.7 volt, IMR Li-Mn battery was made by Efest. The capacity of this battery is 800 mAh. This battery can be used in electronic cigarettes that requires an 18350 cell. This IMR cell has a high discharge rate and is great in variable voltage electronic cigarettes that take an 18350 IMR. This purchase comes with one battery . Sold individually.

Nominal Voltage: 3.7v
Battery Model: 18350v Capacity: 800mAh
Positive:Flat Top
Cycle Life: 500 Cycles

Read more: http://www.viper-vape.com/products/efest-imr-18350-800mah-3-7v.html#ixzz2xlj4kFMM" + "Battery!")
	battery.voltage = 3.7
	battery.wattage = 800
	battery.picture_path = '20130621231316471647__07574.1386806035.360.360.jpg'
	battery.manufacturer = "Efest"
	battery.price = 7.75
	battery.set_compat_with(Button.find(30), true)
	battery.set_works_well_with(Button.find(30), true)
	battery.set_compat_with(Button.find(31), true)
	battery.set_works_well_with(Button.find(31), true)
	battery.save

battery = Battery.create(name: "IMR 26650 3000mah 3.7V" + " Battery", description: "26650, 3.7 volt, IMR lithium ion battery made by Efest. The capacity of this battery is 3000mAh. This battery can be used in electronic cigarettes that requires an 26650 cell. This IMR cell has a high discharge rate and is great in variable voltage electronic cigarettes that take an 26650 IMR. This purchase comes with one battery . Sold individually.

Nominal Voltage: 3.7v
Battery Model: 26650  Capacity: 3000mAh
Positive: Flat top
Cycle Life: 500 Cycles
Max Charging Rate: 4.5amps

NOTE:These IMR cells have much lower internal resistance than regular Li-ion 3.7V cells and they may end up with a higher ending voltage when charged in certain chargers . Please check the voltage of your 26650 IMR battery right out of the charger to see if they are above 4.20V when fully charged with your charger.Above 4.50V may even damage them. DO NOT use the charger if it is overcharging IMR cells. 

Read more: http://www.viper-vape.com/products/efest-imr-26650-3000mah-3-7v.html#ixzz2xllFpeZv" + "Battery!")
	battery.voltage = 3.7
	battery.wattage = 3000
	battery.picture_path = '20130621232059485948__59530.1386806174.360.360.jpg'
	battery.manufacturer = "Efest"
	battery.price = 12.99
	battery.set_compat_with(Button.find(30), true)
	battery.set_works_well_with(Button.find(30), true)
	battery.set_compat_with(Button.find(31), true)
	battery.set_works_well_with(Button.find(31), true)
	battery.save

battery = Battery.create(name: "eVic replacement Battery Samsung 18650" + " Battery", description: "Samsung ICR18650 2600mAh Battery - Flat Top - eVic 
This is the same battery that is included in our Joye eVic Kits.

Read more: http://www.viper-vape.com/evic-battery-samsung-18650/#ixzz2xlkv1C5o" + "Battery!")
	battery.voltage = nil
	battery.wattage = 2600
	battery.picture_path = 'joyetech11__38465.1374950435.360.360.png'
	battery.manufacturer = "Joyetech"
	battery.price = 9.99
	battery.set_compat_with(Button.find(30), true)
	battery.set_works_well_with(Button.find(30), true)
	battery.set_compat_with(Button.find(31), true)
	battery.set_works_well_with(Button.find(31), true)
	battery.save

battery = Battery.create(name: "MNKE IMR 18650 1500mAh Li-MN 3.7v " + " Battery", description: "Safe chemistry Li-MN 3.7V rechargeable battery does not require protection circuit. These cells can handle high amperage and is safe to use in series / multi-cell applications. Can be charged with any Li-Ion battery charger with 4.2V output. Price is per single cell (1x)

Brand Name: MNKE
Size: 18650
Model: MNKE18650A
Type: Li-Mn (High Drain)
Rated Capacity: 1500mAh
Nominal Voltage: 3.8V
Peak Voltage: 4.2V
Dimensions: 18.3mmX65mm
Rechargable: Yes
Protected: No
Chemistry: Lithium manganese Dioxide (Li-Mn02) 
Style: Flat Top
Color: Orange



Read more: http://www.viper-vape.com/products/mnke-imr-18650-1500mah-li-mn-3-7v.html#ixzz2xlldMgYP" + "Battery!")
	battery.voltage = 3.7
	battery.wattage = 1500
	battery.picture_path = '813093109_846_74205.1386807173.600.600__45757.1387908107.360.360.jpg'
	battery.manufacturer = "MNKE"
	battery.price = 11.00
	battery.set_compat_with(Button.find(30), true)
	battery.set_works_well_with(Button.find(30), true)
	battery.set_compat_with(Button.find(31), true)
	battery.set_works_well_with(Button.find(31), true)
	battery.save

battery = Battery.create(name: "SANYO 16650 Li-Ion Battery" + " Battery", description: "Genuine SANYO 2000mAh 16650 rechargeable Li-Ion Battery. Button top converts to flat top becuase button is magnetized and can be removed by just pulling off.

Read more: http://www.viper-vape.com/products/sanyo-16650-li-ion-battery.html#ixzz2xllvOGoe" + "Battery!")
	battery.voltage = 3.7
	battery.wattage = 2000
	battery.picture_path = 'sayno1__13303.1379372759.360.360.png'
	battery.manufacturer = "Sanyo"
	battery.price = 9.00
	battery.set_compat_with(Button.find(30), true)
	battery.set_works_well_with(Button.find(30), true)
	battery.set_compat_with(Button.find(31), true)
	battery.set_works_well_with(Button.find(31), true)
	battery.save

battery = Battery.create(name: "Sony vtc4 18650" + " Battery", description: "Authentic Sony 30AMP VTC4 2100mah 18650 Battery 
 
If you want a battery for high amperage this is the battery for you. 
These batteries are perfect for sub-ohm coils and those that like to go to .3Ω and below. 
SONY 3.7V US18650VTC3 HIGH DRAIN 30A RECHARGEABLE Li-on 18650 Battery 2100mAh 
Battery Maximum Voltage 4.25 V 
Battery Minimum Voltage 2.5 V 
Battery Rated Voltage 3.7 V 
Size: 65 mm long, diameter is 18m
84 amp pulse


Read more: http://www.viper-vape.com/products/sony-vtc4-18650.html#ixzz2xlmRAnZS" + "Battery!")
	battery.voltage = 3.7
	battery.wattage = 2100
	battery.picture_path = 'sony_vct4__65655.1394936589.360.360.png'
	battery.manufacturer = "Sony"
	battery.price = 11.50
	battery.set_compat_with(Button.find(30), true)
	battery.set_works_well_with(Button.find(30), true)
	battery.set_compat_with(Button.find(31), true)
	battery.set_works_well_with(Button.find(31), true)
	battery.save


charger = Charger.create(name: "Efest LUC Multi-function LCD Smart charger" + " Charger", description: "2 battery grooves for charge 10440 / 16340 / 14500 / 14650 / 17500 / 17670 / 18350 / 18490 / 18500 / 18650 / 18700 / 22650 / 26500 / 26650 ect. Li-Mn or Li-ion battery. 

Read more: http://www.viper-vape.com/products/efest-luc-multi-function-lcd-smart-charger.html#ixzz2xlnmFVSy" + "Charger!")
	charger.picture_path = '20130926030109423__94828.1386806659.360.360.jpg'
	charger.manufacturer = "Efest"
	charger.price = 33.99
	charger.set_compat_with(Battery.find(33), true)
	charger.set_compat_with(Battery.find(34), true)
	charger.set_compat_with(Battery.find(35), true)
	charger.set_compat_with(Battery.find(36), true)
	charger.set_compat_with(Battery.find(37), true)
	charger.set_compat_with(Battery.find(38), true)
	charger.set_compat_with(Battery.find(39), true)
	charger.set_compat_with(Battery.find(40), true)
	charger.set_compat_with(Battery.find(41), true)
	charger.set_works_well_with(Battery.find(33), true)
	charger.set_works_well_with(Battery.find(34), true)
	charger.set_works_well_with(Battery.find(35), true)
	charger.set_works_well_with(Battery.find(36), true)
	charger.set_works_well_with(Battery.find(37), true)
	charger.set_works_well_with(Battery.find(38), true)
	charger.set_works_well_with(Battery.find(39), true)
	charger.set_works_well_with(Battery.find(40), true)
	charger.set_works_well_with(Battery.find(41), true)
	charger.save

charger = Charger.create(name: "eGo USB Charger" + " Charger", description: "Both cord and no cord versions are universal USB charger for eGo batteries. Normally it takes 2 hours to charge a 650mah battery completely. 
The LED on charger is red when charging,when the battery is fully charged,LED turns green.Use the eGo USB charger to recharge your batteries with any powered USB device (couputer,etc) or our wall charger (sold seperate)

No cord version means no shorting due to cord shorts.

Both versions work with all ego style batteries  we sell including kanger evod , twist, spinner , normal ego batteries and any other ego threaded batteries we sell.Works with our 510 batteries as well. 



Read more: http://www.viper-vape.com/ego-usb-charger/#ixzz2xloBhOfx" + "Charger!")
	charger.picture_path = '420mA_eGo_Fast_USB_Charger_1_78237__00376.1396448524.360.360.jpg'
	charger.manufacturer = "Viper Vape"
	charger.price = 7.00
	charger.set_compat_with(Button.find(26), true)
	charger.set_works_well_with(Button.find(26), true)
	charger.set_compat_with(Button.find(27), true)
	charger.set_works_well_with(Button.find(27), true)
	charger.save

charger = Charger.create(name: " Efest LUC V4 4 bay LCD USB charger" + " Charger", description: "Efest LUC V4 is high quality with 4 charging channel and big LCD charger, it has four built-in independent charging channels with reverse polarity protection, short circuit protection, over-current protection and Zero voltage activation function, It can automatically monitor battery power and give an alarming notice. LUC V4 charger is compatible with most 3.7V Li-ion or LiMn batteries like 10440, 14500, 14650, 18500, 17670, 18650, 18700, 26500, 26650 etc.It can charge 15270 or 14250 batteries with spacers. 
Besides, with one full charged battery in channel 2, LUC V4 charger also can charge those devices, such as mobile phone, iPad, MP3, Mp4, PSP etc. There are 2 USB sockets of DC5V/0.5A and DC5V/1A. Now comes with car charger!

Read more: http://www.viper-vape.com/products/efest-luc-v4-4-bay-lcd-usb-charger.html#ixzz2xlommGA1" + "Charger!")
	charger.picture_path = '20131017035408648__91028.1386806455.360.360.jpg'
	charger.manufacturer = "Efest"
	charger.price = 38.99
	charger.set_compat_with(Battery.find(33), true)
	charger.set_compat_with(Battery.find(34), true)
	charger.set_compat_with(Battery.find(35), true)
	charger.set_compat_with(Battery.find(36), true)
	charger.set_compat_with(Battery.find(37), true)
	charger.set_compat_with(Battery.find(38), true)
	charger.set_compat_with(Battery.find(39), true)
	charger.set_compat_with(Battery.find(40), true)
	charger.set_compat_with(Battery.find(41), true)
	charger.set_works_well_with(Battery.find(33), true)
	charger.set_works_well_with(Battery.find(34), true)
	charger.set_works_well_with(Battery.find(35), true)
	charger.set_works_well_with(Battery.find(36), true)
	charger.set_works_well_with(Battery.find(37), true)
	charger.set_works_well_with(Battery.find(38), true)
	charger.set_works_well_with(Battery.find(39), true)
	charger.set_works_well_with(Battery.find(40), true)
	charger.set_works_well_with(Battery.find(41), true)
	charger.save

charger = Charger.create(name: "eGo Wall Charger" + " Charger", description: "Wall outlet converter to a USB power source.

Read more: http://www.viper-vape.com/ego-wall-charger/#ixzz2xloziY54" + "Charger!")
	charger.picture_path = 'charger1__08552.1377982108.360.360.png'
	charger.manufacturer = "Viper Vape"
	charger.price = 7.00
	charger.set_compat_with(Button.find(26), true)
	charger.set_works_well_with(Button.find(26), true)
	charger.set_compat_with(Button.find(27), true)
	charger.set_works_well_with(Button.find(27), true)
	charger.save

charger = Charger.create(name: "i2 Nitecore Intellicharger V2" + " Charger", description: " I2 Nitecore Intellicharger I2 Li-ion / NiMH battery charger is a universal, automatic smart-charger compatible with almost all types of rechargeable batteries thus eliminating the need to own several chargers.
 Features:

    Capable of charging 2 batteries simultaneously

    Each of the four battery slots monitors and charges independently
    Automatically identifies Li-ion, Ni-MH and Ni-Cd rechargeable batteries, including 26650/   22650/18650/17670/18490/17500/17335/16340(RCR123)/ 14500
    Features three charging modes (CC, CV and Trickle Charge)
    Automatically detects battery status and selects the appropriate voltage and charge mode
    3 Color LED displays charging progress for each battery
    Automatically stops charging when complete
    Features reverse polarity protection
    Designed for optimal heat dissipation
    Certified by both RoHS and CE


Read more: http://www.viper-vape.com/replacement-parts/i2-nitecore-intellicharger-v2/#ixzz2xlpSf9wc" + "Charger!")
	charger.picture_path = 'DSCN50161__34438.1373396818.360.360.jpg'
	charger.manufacturer = "i2 Nitecore"
	charger.price = 20.00
	charger.set_compat_with(Battery.find(33), true)
	charger.set_compat_with(Battery.find(34), true)
	charger.set_compat_with(Battery.find(35), true)
	charger.set_compat_with(Battery.find(36), true)
	charger.set_compat_with(Battery.find(37), true)
	charger.set_compat_with(Battery.find(38), true)
	charger.set_compat_with(Battery.find(39), true)
	charger.set_compat_with(Battery.find(40), true)
	charger.set_compat_with(Battery.find(41), true)
	charger.set_works_well_with(Battery.find(33), true)
	charger.set_works_well_with(Battery.find(34), true)
	charger.set_works_well_with(Battery.find(35), true)
	charger.set_works_well_with(Battery.find(36), true)
	charger.set_works_well_with(Battery.find(37), true)
	charger.set_works_well_with(Battery.find(38), true)
	charger.set_works_well_with(Battery.find(39), true)
	charger.set_works_well_with(Battery.find(40), true)
	charger.set_works_well_with(Battery.find(41), true)
	charger.save

charger = Charger.create(name: "iTaste Universal Charging Cable" + " Charger", description: "Designed for Upgraded iTaste VV 3.0 battery. It can also charge Joyetech eVic control head, Joyetech eVic easy head, Ismoka iGo control head well.

Read more: http://www.viper-vape.com/products/itaste-universal-charging-cable.html#ixzz2xlpkaOsB" + "Charger!")
	charger.picture_path = 'itasteusb1__57294.1379372655.360.360.png'
	charger.manufacturer = "Innokin"
	charger.price = 7.99
	charger.set_compat_with(Button.find(24), true)
	charger.set_works_well_with(Button.find(24), true)
	charger.set_compat_with(Button.find(25), true)
	charger.set_works_well_with(Button.find(25), true)
	charger.save

charger = Charger.create(name: "Mini Car Charger USB Port" + " Charger", description: "Car charger can charge your e-cigarette but you will still need your USB charger cord.

Charge your electronic cigarette in your car 

Electronic cigarette charger has CE, FCC, SGS, RoHS, UL and PSE approved.



Read more: http://www.viper-vape.com/mini-car-charger-usb-port/#ixzz2xlq5kdVs" + "Charger!")
	charger.picture_path = 'mini_charger__78670.1363915156.360.360.jpg'
	charger.manufacturer = "Viper Vape"
	charger.price = 9.95
	charger.set_compat_with(Button.find(24), true)
	charger.set_works_well_with(Button.find(24), true)
	charger.set_compat_with(Button.find(25), true)
	charger.set_works_well_with(Button.find(25), true)
	charger.save

charger = Charger.create(name: "TrustFire Multifunctional Charger" + " Charger", description: "Output: 4.2V 500mA

Two individual charging channels with dedicated LED status indicator for each channel

Charges one or two batteries at a time, at your choice

Charges 3.6V 10430, 10440, 14500, 16340, 17670, 18350, 18500, 18650 lithium batteries

Use Rechargeable Batteries or With PCB Batteries. Other types of batteries may cause personal injury. Do NOT leave batteries charging unattended/overnight!



Read more: http://www.viper-vape.com/trustfire-multifunctional-charger/#ixzz2xlqZkTku" + "Charger!")
	charger.picture_path = 'Trustfire_TR001_Li_ion_Charger_US_EU_Plug__36596.1376031689.360.360.jpg'
	charger.manufacturer = "Viper Vape"
	charger.price = 15.99
	charger.set_compat_with(Battery.find(33), true)
	charger.set_compat_with(Battery.find(34), true)
	charger.set_compat_with(Battery.find(35), true)
	charger.set_compat_with(Battery.find(36), true)
	charger.set_compat_with(Battery.find(37), true)
	charger.set_compat_with(Battery.find(38), true)
	charger.set_compat_with(Battery.find(39), true)
	charger.set_compat_with(Battery.find(40), true)
	charger.set_compat_with(Battery.find(41), true)
	charger.set_works_well_with(Battery.find(33), true)
	charger.set_works_well_with(Battery.find(34), true)
	charger.set_works_well_with(Battery.find(35), true)
	charger.set_works_well_with(Battery.find(36), true)
	charger.set_works_well_with(Battery.find(37), true)
	charger.set_works_well_with(Battery.find(38), true)
	charger.set_works_well_with(Battery.find(39), true)
	charger.set_works_well_with(Battery.find(40), true)
	charger.set_works_well_with(Battery.find(41), true)
	charger.save

mouthpiece = Mouthpiece.create(name: "360 510 Drip Tip" + " Mouthpiece", description: "It is the most innovative drip tip with 360 degree rotating design. Each drip tip is combined by 2 parts: the connection base and the mouthpiece

Read more: http://www.viper-vape.com/products/360-510-drip-tip.html#ixzz2xlrY3ypl" + "Mouthpiece!")
	mouthpiece.picture_path = '360Driptips__41132.1380734948.360.360.png'
	mouthpiece.manufacturer = "Viper Vape"
	mouthpiece.price = 3.99
	mouthpiece.set_compat_with(Tank.find(8), true)
	mouthpiece.set_works_well_with(Tank.find(8), true)
	mouthpiece.set_compat_with(Tank.find(9), true)
	mouthpiece.set_works_well_with(Tank.find(9), true)
	mouthpiece.save

mouthpiece = Mouthpiece.create(name: "Bullet Drip Tip" + " Mouthpiece", description: " " + "Mouthpiece!")
	mouthpiece.picture_path = 'Bullet_510_Colored_Stainless_Steel_Drip_Tip__48488.1383719619.360.360.jpg'
	mouthpiece.manufacturer = "Viper Vape"
	mouthpiece.price = 4.99
	mouthpiece.set_compat_with(Tank.find(8), true)
	mouthpiece.set_works_well_with(Tank.find(8), true)
	mouthpiece.set_compat_with(Tank.find(9), true)
	mouthpiece.set_works_well_with(Tank.find(9), true)
	mouthpiece.save

mouthpiece = Mouthpiece.create(name: "Colored 510 Drip Tip" + " Mouthpiece", description: "These tips are made of high grade aluminum and allow you to dress up any product you may have that has a removable tip including but not limited to Vivi Novas, Vapeonly tanks, iSmoka tanks, Viva , Smok DCT and many, many more.

Read more: http://www.viper-vape.com/products/colored-510-drip-tip.html#ixzz2xls8v3Mg" + "Mouthpiece!")
	mouthpiece.picture_path = 'coloreddriptips__11779.1383075706.360.360.png'
	mouthpiece.manufacturer = "Viper Vape"
	mouthpiece.price = 4.50
	mouthpiece.set_compat_with(Tank.find(8), true)
	mouthpiece.set_works_well_with(Tank.find(8), true)
	mouthpiece.set_compat_with(Tank.find(9), true)
	mouthpiece.set_works_well_with(Tank.find(9), true)
	mouthpiece.save

mouthpiece = Mouthpiece.create(name: "Custom Stainless Steel 510 Drip Tips" + " Mouthpiece", description: "Custom Stainless Steel 510 Drip Tips made of high grade stainless steel

Read more: http://www.viper-vape.com/products/custom-stainless-steel-510-drip-tips.html#ixzz2xlsThbGh" + "Mouthpiece!")
	mouthpiece.picture_path = 'driptips__46585.1383946714.360.360.png'
	mouthpiece.manufacturer = "Viper Vape"
	mouthpiece.price = 4.99
	mouthpiece.set_compat_with(Tank.find(8), true)
	mouthpiece.set_works_well_with(Tank.find(8), true)
	mouthpiece.set_compat_with(Tank.find(9), true)
	mouthpiece.set_works_well_with(Tank.find(9), true)
	mouthpiece.save

mouthpiece = Mouthpiece.create(name: "Custom Stainless Steel 510 Drip Tips Type B" + " Mouthpiece", description: "Custom Stainless Steel 510 Drip Tips made of high grade stainless steel

Read more: http://www.viper-vape.com/products/custom-stainless-steel-510-drip-tips-type-b.html#ixzz2xlsnBePU" + "Mouthpiece!")
	mouthpiece.picture_path = 'driptipb__54729.1379036578.360.360.png'
	mouthpiece.manufacturer = ""
	mouthpiece.price = 4.99
	mouthpiece.set_compat_with(Tank.find(8), true)
	mouthpiece.set_works_well_with(Tank.find(8), true)
	mouthpiece.set_compat_with(Tank.find(9), true)
	mouthpiece.set_works_well_with(Tank.find(9), true)
	mouthpiece.save

mouthpiece = Mouthpiece.create(name: "Custom Stainless Steel 510 Drip Tips Type C" + " Mouthpiece", description: "Custom Stainless Steel 510 Drip Tips made of high grade stainless steel

Read more: http://www.viper-vape.com/products/custom-stainless-steel-510-drip-tips-type-c.html#ixzz2xlv1CJyc" + "Mouthpiece!")
	mouthpiece.picture_path = 'DRIPTIPC__86968.1379036762.360.360.png'
	mouthpiece.manufacturer = "Viper Vape"
	mouthpiece.price = 4.99
	mouthpiece.set_compat_with(Tank.find(8), true)
	mouthpiece.set_works_well_with(Tank.find(8), true)
	mouthpiece.set_compat_with(Tank.find(9), true)
	mouthpiece.set_works_well_with(Tank.find(9), true)
	mouthpiece.save

mouthpiece = Mouthpiece.create(name: "Hybrid Ming Vase Drip Tip" + " Mouthpiece", description: "New Hybrid Ming Vase Drip Tips. Made of Acrylic and Stainless Steel

Read more: http://www.viper-vape.com/products/hybrid-ming-vase-drip-tip.html#ixzz2xlvQwl4H" + "Mouthpiece!")
	mouthpiece.picture_path = 'Stainless_Steel_Acrylic_Hybrid_Ming_vase_Drip_Tip__01239.1383947144.360.360.jpg'
	mouthpiece.manufacturer = "Viper Vape"
	mouthpiece.price = 4.99
	mouthpiece.set_compat_with(Tank.find(8), true)
	mouthpiece.set_works_well_with(Tank.find(8), true)
	mouthpiece.set_compat_with(Tank.find(9), true)
	mouthpiece.set_works_well_with(Tank.find(9), true)
	mouthpiece.save
=begin
def self.populate_test_compats
		
	10.times do
		types = [Wick, Button, Battery]
		counter = 52
		m = Mouthpiece.find(counter)
		t = types.pop
		case t 
		when Wick
			i = 12
		when Button
			i = 22
		when Battery
			i = 32
		end			
		10.times do
			m.set_compat_with(t.find(i), true)
			m.set_works_well_with(t.find(i), true)
			i += 1
		end
		counter += 1
	end

	10.times do
		types = [Wick, Button, Battery]
		counter = 42
		c = Charger.find(counter)
		t = types.pop
		case t 
		when Wick
			i = 12
		when Button
			i = 22
		when Battery
			i = 32
		end			
		
		10.times do
			c.set_compat_with(t.find(i), true)
			c.set_works_well_with(t.find(i), true)
			i += 1
		end
		counter += 1
	end
	
	10.times do
		types = [Wick, Button]
		counter = 32
		b =Battery.find(counter)
		t = types.pop
		case t 
		when Wick
			i = 12
		when Button
			i = 22
		end		

		10.times do
			b.set_compat_with(t.find(i), true)
			b.set_works_well_with(t.find(i), true)
			i += 1
		end
		counter += 1
	end

end

populate_test_compats



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
=end

