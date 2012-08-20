class CreateNetworkInterfaceTypes < ActiveRecord::Migration
  def self.up
    create_table :network_interface_types do |t|
      t.string :name
      t.text :description
      t.integer :l2_id

      t.timestamps
    end
  end

  def self.down
    drop_table :network_interface_types
  end
end
