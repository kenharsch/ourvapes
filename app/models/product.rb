class Product < ActiveRecord::Base

	# make sure that a product object always has a details object
	before_validation :create_details_obj_if_none_yet
	validates :details, presence: true

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

		has_one :details, class_name: class_name, dependent: :delete, autosave: true

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


	# for some reason delete does not forward deletion to associated objects although the
	# +dependent: :delete+ flag is set; this solves the problem for now
	def delete
		destroy
	end

	# Returns +true+ if this product is compatible (physically fits with) +other_product+,
	# otherwise +false+.
	def compat_to?(other_product)
		return find_pair(self, other_product) != nil
	end

	# Stores whether this product is compatible (physically fits with) +other_product+.
	# +compat == true+ means it is compatible whereas +compat == false+ means it is not.
	def set_compat_to(other_product, compat)
		if compat
			CompatPair.create(pair_order(self, other_product))
		else
			pair = find_pair(self, other_product)
			pair.delete if pair != nil
		end
	end

	# Returns +true+ if both, this product is compatible (physically fits with) +other_product+
	# and this pairs is defined as "working well"; Otherwise this returns +false+.
	def works_well_with?(other_product)
		pair = find_pair(self, other_product)
		return false if pair.nil?
		return pair.works_well?
	end

	# Stores whether this product works well with +other_product+. +well == true+ means it
	# works well whereas +well == false+ means it doesn't.
	#
	# Use +set_compat_to(other_product, false)+ instead if this product is not compatible at all
	# with +other_product+, means if these two physically do not fit together.
	def set_works_well_with(other_product, well)
		pair = find_pair(self, other_product)
		pair = CompatPair.create(pair_order(self, other_product)) if pair.nil?
		pair.works_well = well
		pair.save
	end

	def self.clear_compat
		CompatPair.delete_all
	end


	private

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

	# Getter, setter, and boolean getter (in case it's a boolean attribute)
	# for each delegated attribute
	def self.define_accessors(attributes)
		attributes.each do |attribute_name|
			def_delegators :details,
			:"#{attribute_name}", :"#{attribute_name}=", :"#{attribute_name}?"
		end
	end
end