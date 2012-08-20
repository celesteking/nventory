# add some new tooltips
ToolTip.create :model       => 'Vip',
               :attr        => 'lb_pools',
               :description => 'Organizational unit which ties nodes to a VIP'
ToolTip.create :model       => 'Vip',
               :attr        => 'load_balancer',
               :description => 'Load Balancer transparently redirects incoming HTTP requests from Web clients to a set of Web servers.'
ToolTip.create :model       => 'VipLbPoolAssignment',
               :attr        => 'vip',
               :description => 'Virtual IP - an IP address that is shared among multiple domain names or multiple servers. A virtual IP address eliminates a host\'s dependency upon individual network interfaces. Incoming packets are sent to the system\'s VIP address, but all packets travel through the real network interfaces.

A VIP can belong to a load balancing device such as F5 BigIP or can be a clustered VIP such as that used in RedHat Cluster or Windows Load Balancing Service.'

# Add some default tooltips
ToolTip.reset_column_information
ToolTip.create :model       => 'Node',
               :attr        => 'status',
               :description => 'Current state of node'
ToolTip.create :model       => 'Node',
               :attr        => 'name_aliases',
               :description => 'Other names this node known by'
ToolTip.create :model       => 'Node',
               :attr        => 'contact',
               :description => 'A user whom is point of contact <br />for this node'
ToolTip.create :model       => 'NodeRack',
               :attr        => 'datacenter',
               :description => 'Where servers are hosted'
ToolTip.create :model       => 'Node',
               :attr        => 'node_rack',
               :description => 'Where servers are mounted, within a datacenter'
ToolTip.create :model       => 'volume_node_assignment',
               :attr        => 'volume',
               :description => 'Network storage, shared by a node'
ToolTip.create :model       => 'Account',
               :attr        => 'login',
               :description => 'Local user account login'
ToolTip.create :model       => 'Node',
               :attr        => 'node_groups',
               :description => 'Organizational object for nodes'
ToolTip.create :model       => 'Node',
               :attr        => 'services',
               :description => 'Applications a node belongs to'
ToolTip.create :model       => 'Node',
               :attr        => 'lb_pools',
               :description => 'Group of nodes that serve a VIP'
ToolTip.create :model       => 'VipLbPoolAssignment',
               :attr        => 'vip',
               :description => 'Virtual IP Address - usually hosted by a Load Balancer'
ToolTip.create :model       => 'Node',
               :attr        => 'hardware_profiles',
               :description => 'Hardware specifications and type of node'
ToolTip.create :model       => 'Node',
               :attr        => 'operating_system',
               :description => 'Interface between hardware and software of a node'
ToolTip.create :model       => 'Node',
               :attr        => 'produced_outlets',
               :description => 'Network ports, power outlets, or console ports<br />shared by a node'
ToolTip.create :model       => 'NodeGroup',
               :attr        => 'subnets',
               :description => "Each identifiably separate part of an organization's network"
ToolTip.create :model       => 'Node',
               :attr        => 'used_space',
               :description => 'Amount of disk space in use <br /><font size=-1 color=red>** Disk space info only reflects<br />"/" and "/home</font>'
ToolTip.create :model       => 'Node',
               :attr        => 'avail_space',
               :description => 'Amount of disk space available <br /><font size=-1 color=red>** Disk space info only reflects<br />"/" and "/home</font>'
ToolTip.create :model       => 'Node',
               :attr        => 'os_processor_count',
               :description => 'Number of <font color=red>physical</font> processors seen by the OS'
ToolTip.create :model       => 'Node',
               :attr        => 'os_virtual_processor_count',
               :description => 'Number of <font color=red>all</font> processors seen by the OS'
ToolTip.create :model       => 'Node',
               :attr        => 'os_virtual_processor_count',
               :description => 'Number of <font color=red>all</font> processors seen by the OS'
ToolTip.create :model       => 'Node',
               :attr        => 'network_interfaces',
               :description => 'Network interfaces such as ethernet or fiber, belonging to a node'

# Some System Install Defaults
Account.create(:name => 'admin', :login => 'admin', :password => 'admin', :email_address => 'admin@domain.com', :admin => true)
Account.create(:name => 'autoreg', :login => 'autoreg', :password => 'autoreg', :email_address => 'autoreg@domain.com', :admin => true)
admin = Account.find_by_login('admin')
admin.authz.has_role 'admin'

# Add the default profile
LbProfile.reset_column_information
LbProfile.create :protocol    => 'tcp',
                 :port        => 80,
                 :lbmethod    => 'round_robin',
                 :healthcheck => 'http'

Account.all.each do |user|
	user.admin = false
	userag     = AccountGroup.create({ :name => "#{user.login}.self", :slfgrp => 1 })
	user.authz = userag
	user.save
	userag.has_role 'updater', userag
	userag.has_role 'updater', user
	if user.login == 'autoreg'
		userag.has_role 'creator', Node
		userag.has_role 'updater', Node
	end
end
admins = AccountGroup.create({ :name => 'Administrators' })
admins.has_role 'admin'

UtilizationMetricName.create :name => 'login_count'
UtilizationMetricName.reset_column_information
UtilizationMetricName.create :name => 'percent_cpu'
