
# JS rendering helper
module JSHelper
	def show_spinner(name)
		javascript_tag("Element.show('loading_#{name}_spinner')")
	end

	def hide_spinner(name)
		javascript_tag("Element.hide('loading_#{name}_spinner')")
	end
end