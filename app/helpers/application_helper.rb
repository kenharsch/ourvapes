module ApplicationHelper

	def gravatar_url(user, size)
		gravatar_id = Digest::MD5::hexdigest(user.email).downcase
		return "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=retro"
	end

	def works_well_list_url
		return "/product_list/list?compats[]=#{CompatPair::WORKS_WELL}"
	end
end
