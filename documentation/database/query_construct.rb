my_config_ids = [53, 17, 25, 48]
compats = [3, 2]
my_config = MyConfig.new
my_config_ids.each {|id| my_config.add_by_id(id)}

r = Product.connection.select_values("
	SELECT DISTINCT products.id
	FROM products
	JOIN compat_pairs ON (products.id = prod1_id OR products.id = prod2_id)
	WHERE (prod1_id IN #{my_config_ids} OR prod2_id IN #{my_config_ids})
		AND compatibility IN #{compats}
		AND products.id NOT IN #{my_config_ids}")

relation = Product.select("products.id").distinct.
joins("JOIN compat_pairs ON (products.id = prod1_id OR products.id = prod2_id)").
where("(prod1_id IN (:my_config_ids) OR prod2_id IN (:my_config_ids))
	AND compatibility IN (:compats)
	AND products.id NOT IN (:my_config_ids)",
	my_config_ids: my_config_ids, compats: compats)



http://vaperater.herokuapp.com/configuration?&ids[]=53&ids[]=8&ids[]=17&ids[]=25&ids[]=48

53: Mouthpiece
08: Tank
17: Wick
25: Button
48: Charger



yield(Product::TYPE_MOUTHPIECE, Product::TYPE_TANK)
yield(Product::TYPE_TANK, Product::TYPE_WICK)
yield(Product::TYPE_TANK, Product::TYPE_BUTTON)
yield(Product::TYPE_BUTTON, Product::TYPE_BATTERY)
yield(Product::TYPE_BUTTON, Product::TYPE_CHARGER)
yield(Product::TYPE_BATTERY, Product::TYPE_CHARGER)

UNKNOWN = 0
INCOMPATIBLE = 1
WORKS_BADLY = 2
WORKS_WELL = 3