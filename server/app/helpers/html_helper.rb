
# Various HTML element rendering methods
module HTMLHelper
	def render_loading_spinner(name)
		"<p id='loading_#{name}_spinner'>
			<b><font color=red size=3>Loading...<br /></font></b>" +
			image_tag('spinner.gif', :alt => 'Loading') +
		"</p>"
	end
end
