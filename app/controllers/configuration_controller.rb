class ConfigurationController < ApplicationController

	def index
		@add_or_change = "Add"

		#populate_database(100)
		#empty_database

		@newprod = []
		Product.all.each do |prod|
			@newprod << [prod.name, prod.id]
		end

		find_parts

	end



	def add
		@data = params["data"]
		conf = {tank: 70}
		hash = {conf: conf}
		redirect_to "/configuration?#{hash.to_param}"
	end

	def remove
		conf = params["conf"] || {}
		conf.delete(params["remove"])
		hash = {conf: conf}
		redirect_to "/configuration?#{hash.to_param}"

	end



	def find_parts
		@partslist = ["mouthpiece","tank","wick","button","battery","charger"]
		@conf = {}
		params["conf"] ||= {}

		params["conf"].each do |part_type, part_id|
			model = part_type.capitalize.constantize
			if model.exists?(part_id)
				@conf[part_type] = model.find(part_id).name
			else
				flash[:notice] = "Invalid "+ part_type +" selection"
				params["conf"].delete(params["conf"].index(part_type))
			end
		end


	end

	def show

	end

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

	
end
