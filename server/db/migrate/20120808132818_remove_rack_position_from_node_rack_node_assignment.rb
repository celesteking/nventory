class RemoveRackPositionFromNodeRackNodeAssignment < ActiveRecord::Migration
  def self.up
	  remove_column :node_rack_node_assignments, :position
  end

  def self.down
	  add_column :node_rack_node_assignments, :position, :integer
  end
end
