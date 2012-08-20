class AddNetworkInterfaceTypeToNetworkInterface < ActiveRecord::Migration
  def self.up
    add_column :network_interfaces, :network_interface_type_id, :integer
  end

  def self.down
    remove_column :network_interfaces, :network_interface_type_id
  end
end
