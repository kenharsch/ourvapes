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

  def gravatar_url(user, size)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    return "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=retro"
  end
end
