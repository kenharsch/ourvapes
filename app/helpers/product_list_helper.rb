module ProductListHelper
	def manu_filter(manu_facet)
		selected = @sel_manus.member?(manu_facet.value)

		# the filter_name is needed to have the same attribute accessible through JQuery
		# for checkbox and label (both having the class manu-filter)
		common_options = {class: "manu-filter", filter_name: manu_facet.value, selected: selected}

		chck_box_options = common_options.clone
		chck_box = check_box_tag(("manufacturer_" + manu_facet.value).to_sym, manu_facet.value, selected, common_options)

		common_options[:class] << " clickable-text"
		chck_box_label = label(:manufacturer, manu_facet.value)

		return "#{chck_box} #{chck_box_label} (#{manu_facet.count})".html_safe
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
		radio_label = label(:prod_type, type, class: "type-filter");
		return "#{radio_btn} #{radio_label}".html_safe
	end

	def manus_filter_clear_button()
		return if @sel_manus.empty?
		html = " - "
		html << span("Clear", class: 'clickable-text', id: 'manu-filter-clear')
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
