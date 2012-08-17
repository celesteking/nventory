class AddRackPositionToNodeRackNodeAssignment < ActiveRecord::Migration
  def self.up
    add_column :node_rack_node_assignments, :upos, :integer
  end

  def self.down
    remove_column :node_rack_node_assignments, :upos
  end
end
