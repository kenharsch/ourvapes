class Product < ActiveRecord::Base

	# needed to use the def_delegators method
	extend Forwardable

	# Use in subclasses like:
	# class Wick < Product
	# 	delegate_details :resistance_in_ohm, to: 'WickDetails'
	# end

	# the following method is inspired by this great article:
	# start http://nathanmlong.com/2013/05/better-single-table-inheritance/
	def self.delegate_details(*attributes)
		options = attributes.extract_options!

		# raises an error if no value
		class_name = options.fetch(:to) {
			raise ArgumentError.new "You must specify the name of the details association"
		}

		has_one :details, class_name: class_name, dependent: :delete
		default_scope {joins(:details)}

		# returns the object containing the type specific details;
		# if the details objcect is not set yet, this creates a new details object
		# and sets the foreign keys appropriately to make it accessible from here
		define_method :details do
			super() || build_details
		end

		define_accessors attributes
	end

	# for some reasone delete does not forward deletion to associated objects
	# although the "dependent: :delete" flag is set; this solves the problem for now
	def delete
		destroy
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
end