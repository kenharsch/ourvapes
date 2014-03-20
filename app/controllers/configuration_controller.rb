class ConfigurationController < ApplicationController

	def index
		@partslist = ["mouthpiece","tank","wick","button","battery","charger"]
		@add_or_change = "Add"
		find_parts
	end

	def add(add_type = params["add_type"], add_id = params["add_id"])
		conf = params["conf"] || {}
		conf[add_type] = add_id
		go_to_config(conf)
	end

	def remove(remove_item = params["remove"])
		conf = params["conf"] || {}
		conf.delete(remove_item)
		go_to_config(conf)
	end

	def clear
		go_to_config
	end

	def go_to_config(conf = {})
		hash = {conf: conf}
		redirect_to "/configuration?#{hash.to_param}"
	end

	def find_parts
		@conf_objects = {} #conf_objects is used in the configuration view to see product info
		params["conf"] ||= {}

		params["conf"].each do |part_type, part_id| #go through full array
			part_class = part_type.capitalize.constantize
			if part_class.exists?(part_id) #validate existence
				@conf_objects[part_type] = part_class.find(part_id)
			else #could not find 
				flash[:notice] = "Invalid " + part_type + " selection"
				remove(part_type) #remove and redirect
			end
		end


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
