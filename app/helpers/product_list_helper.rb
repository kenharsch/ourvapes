module ProductListHelper
	def manu_filter(manu_facet)
		selected = @sel_manus.member?(manu_facet.value)
		chck_box = check_box_tag(:manufacturer, manu_facet.value, selected)

		link_body = "#{manu_facet.value} (#{manu_facet.count})"

		key_prefix = (selected ? "remove" : "add")
		link_url = "update?#{key_prefix}_manu=#{manu_facet.value}"

		link = link_to(link_body, link_url, class: "type_list")

		return "#{chck_box} #{link}".html_safe
	end
end
