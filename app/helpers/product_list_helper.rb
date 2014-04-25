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

	def type_filter_clear_button()
		return "" if @type_filter.blank?
		return span("- Clear", class: 'type-filter clickable-text', filter_name: 'none')
	end

	def type_filter(type)
		radio_btn = radio_button_tag(:prod_type, type, @type_filter == type,
			class: "type-filter", filter_name: type)
		label = span(type, class: "type-filter clickable-text", filter_name: type)

		return "#{radio_btn} #{label}".html_safe
	end

	private

	# returns a safe html span
	# body:: what to show on the page
	# options:: a hash with options like class and filter_name
	def span(body, options)
		return content_tag(:span, body, options)
	end
end
