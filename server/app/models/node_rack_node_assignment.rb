class NodeRackNodeAssignment < ActiveRecord::Base
  acts_as_authorizable
  acts_as_audited
  
  named_scope :def_scope
  
  acts_as_reportable
  
  belongs_to :node_rack 
  belongs_to :node 
  
  #acts_as_list :scope => :node_rack, :column => 'upos'

  before_validation :pick_available_upos
  
  validates_presence_of :node_rack_id, :node_id
  validates_uniqueness_of :node_id
  validates_uniqueness_of :upos, :allow_nil => true
  validates_numericality_of :upos, :only_integer => true, :allow_nil => true

  validate :no_virtual_guest, :if => 'node'
  validate :upos_within_rack_height, :if => 'node_rack'
  validate :node_upos_within_free_space, :if => ['node_rack', 'upos']

  def no_virtual_guest
	  if node and node.virtual_guest?
		  errors.add(:node, "#{node.name} is a #{node.virtualarch} virtual guest therefore cannot be assigned to a physical rack space\n")
		  false
	  end
	  true
  end

  def upos_within_rack_height
	  node_height = node.hardware_profile.rack_size
	  unless (1..(node_rack.u_height - node_height + 1)).include?(upos)
		  errors.add(:upos, "with height #{node_height} couldn't be fit into rack, which size is 1-#{node_rack.u_height}")
		  false
	  end
	  true
  end

  # Make sure Upos doesn't span occupied slots
  def node_upos_within_free_space
	  node_height = node.hardware_profile.rack_size

	  unless fits_into_rack?(id, upos, node_height)
		  errors.add(:upos, "for node (#{node_height}U) covers one or more of occupied slots in #{upos}..#{upos+node_height-1}")
		  false
	  end
	  true
  end

  def pick_available_upos
	  if upos.nil? and node_rack and node
		  self.upos = find_empty_slot_in_rack(node.hardware_profile.rack_size)
		end
  end
  
  def self.default_search_attribute
    'assigned_at'
  end
 
  def before_create 
    self.assigned_at ||= Time.now 
  end

	private
  def fits_into_rack?(ass_id, upos, height)
	  wanted_range = upos..(upos + height - 1)
	  if amap = get_rack_availability_map
	    amap.map{|id, min, max| min..max unless id == ass_id }.none?{|occupied_range| occupied_range & wanted_range }
		end
  end

  def find_empty_slot_in_rack(desired_height)
	  avail_rack_range = 1..(node_rack.u_height)
	  if amap = get_rack_availability_map
		  amap.each do |id, min, max|
			  return avail_rack_range.begin if min - avail_rack_range.begin >= desired_height
			  avail_rack_range = (max + 1)..avail_rack_range.end
		  end
	  end
	  return avail_rack_range.begin if avail_rack_range.end - avail_rack_range.begin + 1 >= desired_height
	  nil
  end

  public :find_empty_slot_in_rack

  # @return [Array<Fixnum, Fixnum, Fixnum>] U slot availability map
  # @example
  #   => [[16, 1, 2], [17, 5, 8], [11, 22, 23]]
	def get_rack_availability_map
		if mixmap = NodeRackNodeAssignment.find_by_sql("SELECT `node_rack_node_assignments`.id, upos AS min_upos, upos + hardware_profiles.rack_size - 1 AS max_upos FROM `node_rack_node_assignments` INNER JOIN `nodes` ON `nodes`.id = `node_rack_node_assignments`.node_id INNER JOIN `hardware_profiles` ON `hardware_profiles`.id = `nodes`.hardware_profile_id ORDER BY upos ASC")
			mixmap.collect {|ass| [ass.id, ass.min_upos.to_i, ass.max_upos.to_i]}
		end
	end
end
