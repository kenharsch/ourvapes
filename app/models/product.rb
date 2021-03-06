class Product < ActiveRecord::Base

	TYPE_MOUTHPIECE = "Mouthpiece"
	TYPE_TANK = "Tank"
	TYPE_WICK = "Wick"
	TYPE_BUTTON = "Button"
	TYPE_BATTERY = "Battery"
	TYPE_CHARGER = "Charger"
	TYPE_KIT = "Kit"
	TYPE_JUICE = "Juice"

	ALL_TYPES = [TYPE_MOUTHPIECE, TYPE_TANK, TYPE_WICK, TYPE_BUTTON, TYPE_BATTERY,
		TYPE_CHARGER, TYPE_KIT, TYPE_JUICE]

	has_many :ratings
	belongs_to :user
	# make sure that a product object always has a details object
	before_validation :create_details_obj_if_none_yet
	validates :details, presence: true

	searchable do
		# the fields used for fulltext search
		text :name, :description, :type, :manufacturer

		# the fields used for text filtering
		string :type
		string :manufacturer

		# joining with compat_pair for compatibility filters
		integer :id

		#join(:prod1_id, :type => :integer, :join_string => 'from=prod2_id to=id')
		# join(:prod1_id, type: :integer, join_string: 'from=prod2_id to=id', as: 'compat_prod1_id')
		# join(:prod2_id, type: :integer, join_string: 'from=prod1_id to=id', as: 'compat_prod2_id')

		# join(:compatibility, type: :integer, join_string: 'from=prod1_id to=id', as: 'compat1')
		# join(:compatibility, type: :integer, join_string: 'from=prod2_id to=id', as: 'compat2')
	end

	# needed to use the def_delegators method
	extend Forwardable

	# Use in subclasses like:
	# class Wick < Product
	# 	delegate_details :resistance_in_ohm, to: 'WickDetails'
	# end

	# the following method is inspired by this great article:
	# http://nathanmlong.com/2013/05/better-single-table-inheritance/
	def self.delegate_details(*attributes)
		options = attributes.extract_options!

		# raises an error if no value
		class_name = options.fetch(:to) {
			raise ArgumentError.new "You must specify the name of the details association"
		}

		has_one :details, class_name: class_name, dependent: :destroy, autosave: true

		# needed for queries like Tanks.where(volume_in_ml: '> 12')
		# because this accesses attributes stored in the details object
		default_scope {joins(:details)}

		# defines the details getter
		# needed for calls like Tank.create(volume_in_ml: 12)
		# where the after_initialize method was not called yet
		define_method :details do
			build_details if super().nil? # if there is no associated details object
			super()
		end

		define_accessors attributes
	end

	def self.clear_compat
		CompatPair.destroy_all
	end


	# Returns one of the following: CompatPair::UNKNOWN, CompatPair::INCOMPATIBLE,
	# CompatPair::WORKS_BADLY, CompatPair::WORKS_WELL
	# The result for +a.compat_with(b)+ and +b.compat_with(a)+ is always the same.
	def compat_with(other_product)
		pair = find_pair(self, other_product)

		return CompatPair::UNKNOWN if pair.nil?
		return pair.compatibility
	end

	# Stores the compatibility for this product and +other_product+.
	# After calling +a.set_compat_with(b, compat)+ there is no need to call
	# +b.set_compat_with(a, compat)+.
	# compat:: one of the following: CompatPair::UNKNOWN, CompatPair::INCOMPATIBLE,
	# CompatPair::WORKS_BADLY, CompatPair::WORKS_WELL
	def set_compat_with(other_product, compat)
		pair = find_pair(self, other_product)

		# compat == CompatPair::UNKNOWN means the corresponding pair should not exist
		# in the database

		return if (compat == CompatPair::UNKNOWN && pair.nil?)

		if (compat == CompatPair::UNKNOWN && pair.present?)
			pair.destroy
			return
		end

		pair = CompatPair.create(pair_order(self, other_product)) if pair.nil?

		pair.compatibility = compat
		pair.save
	end

	def average_rating
		zero = ratings.where("score = 0").count
		if ratings.count == 0
			return 0.0
		elsif zero > 0
			return ratings.sum(:score) / (ratings.size - zero).to_f
		else
			return ratings.sum(:score) / ratings.size.to_f
		end
	end

	def rating_count
		ratings.size - (ratings.where("score = 0").count)
	end

	private

	# Getter, setter, and boolean getter (in case it's a boolean attribute)
	# for each delegated attribute
	def self.define_accessors(attributes)
		attributes.each do |attribute_name|
			def_delegators :details,
			:"#{attribute_name}", :"#{attribute_name}=", :"#{attribute_name}?"
		end
	end

	def find_pair(prod1, prod2)
		return CompatPair.find_by(pair_order(prod1, prod2))
	end

	# Returns a hash which can be used for CompatPair ActiveRecord actions. This ensures
	# that +prod1+ has a lower id than +prod2+ as it is required for	+CompatPair+ to
	# avoid redundant pair storage.
	def pair_order(prod1, prod2)
		prod1, prod2 = prod2, prod1 if prod2.id < prod1.id
		return {prod1: prod1, prod2: prod2}
	end

	def create_details_obj_if_none_yet
		build_details if details.nil?
	end

end