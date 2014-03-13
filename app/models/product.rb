class Product < ActiveRecord::Base
	extend Forwardable
	# Thankfully taken from http://nathanmlong.com/2013/05/better-single-table-inheritance/
	# start http://nathanmlong.com/2013/05/better-single-table-inheritance/
	# Use in subclasses like:
	# delegate_details :win_ratio, :tanning_time, to: :wrestling_details
	def self.delegate_details(*attributes)
		options = attributes.extract_options!
		association_name = options.fetch(:to) {
			raise ArgumentError.new "You must specify the name of the details association"
		}

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