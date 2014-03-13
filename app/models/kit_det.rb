class KitDet < ActiveRecord::Base
	has_one :mouthpiece, class_name: 'Product'
	has_one :tank, class_name: 'Product'
	has_one :wick, class_name: 'Product'
	has_one :button, class_name: 'Product'
	has_one :battery, class_name: 'Product'
	has_one :charger, class_name: 'Product'
	has_one :cartridge, class_name: 'Product'
end
