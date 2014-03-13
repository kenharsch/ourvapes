module ApplicationHelper

	def create_kit_url
		# Turn the current kit into a URL-ready parameter
		if params["kit"].nil?
			return ""
		end
  		url = "?"
  		params["kit"].each do |key, value|
  			url += "kit[" + key.to_s + "]=" + value.to_s + "&"
  		end
  		return url[0..-2]
  	end

end
