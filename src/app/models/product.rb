class Product < ActiveRecord::Base
	validates :type, :presence => true
	validates :name, :presence => true
end
