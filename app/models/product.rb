class Product < ActiveRecord::Base

	# needed to use the def_delegators method
	extend Forwardable

	# Use in subclasses like:
	# class Wick < Product
	# 	has_one :wick_details, class_name: 'WickDet'
	# 	delegate_details :resistance_in_ohm, to: :wick_details
	# 	default_scope joins(:wick_det)
	# end

	# start http://nathanmlong.com/2013/05/better-single-table-inheritance/
	def self.delegate_details(*attributes)
		options = attributes.extract_options!

		# raises an error if no value
		association_name = options.fetch(:to) {
			raise ArgumentError.new "You must specify the name of the details association"
		}

		# returns the object containing the type specific details;
		# if the details objcect is not set yet, this creates a new details object
		# and sets the foreign keys appropriately to make it accessible from here
		define_method association_name do
			super() || send("build_#{association_name}")
		end

		attributes.each do |attribute_name|
		    # Getter, setter, and boolean getter (in case it's a boolean attribute)
		    def_delegators association_name,
		    :"#{attribute_name}", :"#{attribute_name}=", :"#{attribute_name}?"
		  end
		end
	# end http://nathanmlong.com/2013/05/better-single-table-inheritance/
end