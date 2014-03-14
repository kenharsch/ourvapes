class Product < ActiveRecord::Base

	# make sure that a product object always has a details object
	after_initialize :create_details_obj_if_needed

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


	# for some reason delete does not forward deletion to associated objects
	# although the "dependent: :delete" flag is set; this solves the problem for now
	def delete
		destroy
	end

	private

	def create_details_obj_if_needed
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