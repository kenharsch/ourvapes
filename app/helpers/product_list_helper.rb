module ProductListHelper
	def manu_filter(manu_facet)
		selected = @sel_manus.member?(manu_facet.value)

		# the filter_name is needed to have the same attribute accessible through JQuery
		# for checkbox and label (both having the class manu-filter)
		common_options = {class: "manu-filter", filter_name: manu_facet.value, selected: selected}

		chck_box_options = common_options.clone
		chck_box = check_box_tag(:manufacturer, manu_facet.value, selected, common_options)

		label_body = "#{manu_facet.value} (#{manu_facet.count})"
		common_options[:class] << " clickable-text"
		label = span(label_body, common_options)

		return "#{chck_box} #{label}".html_safe
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
