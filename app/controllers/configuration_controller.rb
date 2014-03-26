class ConfigurationController < ApplicationController
	before_action :build_kit, only: [:index, :add, :remove]

	def index
		@add_or_change = "Add"
		check_compatibility
	end

	def add(add_type = params["add_type"], add_id = params["add_id"])
		@kit_obj.add_by_id(add_type,add_id)
		go_to_config
	end

	def remove(remove_item = params["remove"])
		@kit_obj.remove(remove_item)
		go_to_config
	end

	def clear
		go_to_config
	end

	def go_to_config
		redirect_to "/configuration?#{@kit_obj.to_url}"
	end

	def build_kit
		@partslist = Kit::HW_TYPES
		@kit_obj = Kit.new
		params["conf"] ||= {}
		error_flag = false;

		params["conf"].each do |part_type, part_id| #go through full array
			part_class = part_type.capitalize.constantize

			if part_class.exists?(part_id) #validate existence
				@kit_obj.update(part_type => part_class.find(part_id)) 
			else #could not find 
				flash[:error] = "Invalid " + part_type + " selection"
				error_flag = true
			end
		end
		go_to_config if error_flag
		@conf_objects = @kit_obj.to_hash

	end

	def check_compatibility
		@checker = ConfigChecker.new(@kit_obj)
		@kit_obj
	end

	def show

	end

=begin
	def populate_database(num = 10)
		descriptions = ["sour","crazy","cool","agonizing","painful","slippery","damp","humid","fresh-squeezed","upside-down","inside-out","super", "ultra", "happy", "evil", "fantastic", "splendid", "turbo", "insatiable", "fastidious", "fetid", "arctic", "fortunate", "powerful", "simple", "complicated", "angry", "artery-clogging", "gastric", "smart", "short", "tall", "slow", "aggressive", "soft", "squishy", "yummy", "annoying", "lively", "friendly", "gross", "colorful", "sleepy", "orange", "blue", "green", "yellow", "heavy", "warm", "cold", "intrepid", "enthusiastic", "frustrating", "jive", "tired", "smelly", "flirty", "drunk", "tart", "sweet", "jumpy", "nervous", "strange", "crappy", "stupid", "idiotic", "tiny", "corn-fed", "collapsible", "pocket-sized", "supreme", "delicious", "belligerent", "sublime", "helvetica", "Greek","Italian","Spanish","Mexican","French","German","bovine","Guatamalan","Cuban","Canadian","Dutch","Egyptian","Israeli","Russian","Ukranian","lavender","indigo","Chinese","Japanese","Korean","Thai","spicy","mango","peanut","avocado","apple","pear","cherry","tomato","potato","kiwi","lemon","lime","peach","blueberry","fuschia","cerulean","veridian","unfortunate","tragic","crooked","barbaric","intense","groovy","Indian","Pakistani","Nepalese","Brazilian","Peruvian","perverted","Slavic"]
		types = ["wick","tank","cartridge","juice","mouthpiece","battery","button","charger"]
		
		(0..num).each do
			prefix = descriptions.sample.capitalize + " " + descriptions.sample
			ptype = types.sample.capitalize
			(ptype.constantize).create(name: (prefix + " " + ptype))
		end
	end

	def empty_database
		Product.all.each do |prod|
			prod.destroy
		end
	end
=end
	
end
