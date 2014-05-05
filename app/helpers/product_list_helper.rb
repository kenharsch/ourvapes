module ProductListHelper
	def manu_filter(manu_facet)
		selected = @sel_manus.member?(manu_facet.value)

		chck_box = check_box_tag(("manufacturer_" + manu_facet.value).to_sym,
			manu_facet.value, selected, class: "manu-filter", filter_name: manu_facet.value)

		chck_box_label = label(:manufacturer, manu_facet.value.gsub("\s", "_"))

		# return "#{chck_box} #{chck_box_label} (#{manu_facet.count})".html_safe
		return "#{chck_box} #{chck_box_label}".html_safe
	end

	def type_filter_clear_button()
		return "" if @type_filter.blank?
		html = " - "
		html << span("Clear", class: 'type-filter clickable-text', filter_name: 'none')
		return html.html_safe
	end

	def type_filter(type)
		radio_btn = radio_button_tag(:prod_type, type, @type_filter == type,
			class: "type-filter", filter_name: type)
		radio_label = label(:prod_type, type);
		return "#{radio_btn} #{radio_label}".html_safe
	end

	def manu_filter_clear_button()
		return if @sel_manus.empty?
		html = " - "
		html << span("Clear", class: 'clickable-text', id: 'manu-filter-clear')
		return html.html_safe
	end

	def compat_filter(title, type)
		selected = @compats.member?(type.to_s)

		tag = ("compat " + title).classify.delete(' ').underscore.to_sym

		html = "<dd>"
		html << check_box_tag(tag, title, selected, class: "compat-filter",
			filter_name: type)
		html << label_tag(tag, title, class: "type_list")
		html << "</dd>"
		return html.html_safe
	end

	def compat_filter_clear_button()
		return if @compats.empty?
		html = " - "
		html << span("Clear", class: 'clickable-text', id: 'compat-filter-clear')
		return html.html_safe
	end

	private

	# returns a safe html span
	# body:: what to show on the page
	# options:: a hash with options like class and filter_name
	def span(body, options)
		return content_tag(:span, body, options)
	end
end
