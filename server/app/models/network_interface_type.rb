class NetworkInterfaceType < ActiveRecord::Base
	acts_as_authorizable
	acts_as_audited

  named_scope :def_scope

	acts_as_reportable


	has_many :network_interfaces
end
