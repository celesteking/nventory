module OutletsHelper
	# Sorts by [what] type of collection
	def sort_by_name(collection, what, &block)
		res_coll = case what
      when 'Power', 'Network'
				collection.sort{|a,b| a.name.to_i <=> b.name.to_i }
			else
				collection.sort{|a,b| a.name <=> b.name}
			end

		res_coll.each(&block) if block

		res_coll
	end

	def format_consumer(name, component_name, component_id)

	end
end
