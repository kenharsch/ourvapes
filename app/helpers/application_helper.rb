module ApplicationHelper

	def create_kit_url(parts = params["kit"], skip=nil)
		# Turn the current kit into a URL-ready parameter
		if parts.nil?
			return ""
		end
    url = "?"
    parts.each do |key, value|
      if key != skip
          # don't include the skip in the url (for deleting)
          url += "kit[" + key.to_s + "]=" + value.to_s + "&"
      end
    end
      return url[0..-2]
  end

end
