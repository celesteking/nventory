module NodesHelper
	include OutletsHelper

  def logins_descr
    "This is the number of logins calculated<br />" +
    " by the utilization metrics controller<br />" +
    " by registering when the node does its cli registration<br />" +
    " daily and parses through sar<br />" 
  end

  def allow_add_ngna
  end

  def sort_outlets
    @node.produced_outlets.sort do |a,b|
      if (a.name =~ /\W/) || (b.name =~ /\W/)
        firstresult = /(\d+)\W(\d+)/.match(a.name)
        lastresult= /(\d+)\W(\d+)/.match(b.name)
        a1 = firstresult[1]
        b1 = lastresult[1]
        if a1 == b1
          first = firstresult[2].to_i
          last = lastresult[2].to_i
        else
          first = a1.to_i
          last = b1.to_i
        end
      else
        first = /(\d+)/.match(a.name)[0].to_i
        last = /(\d+)/.match(b.name)[0].to_i
        if first == last
          first = /\d+(\w)/.match(a.name)[0]
          last = /\d+(\w)/.match(b.name)[0]
        end
      end
      first <=> last
    end
  end

	def format_node_location(node)
		if nrna = node.node_rack_node_assignment
			node_upos = nrna.upos
			if nr = nrna.node_rack
				rack_name = nr.name
				if dc = nr.datacenter
					dc_name = dc.name
				end
			end
		end

		[node_upos, rack_name, dc_name]
	end

end
