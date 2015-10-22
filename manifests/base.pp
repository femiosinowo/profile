class profile::base {
	include ssh
	include motd
	include stdlib
	include resolver
	include selinux
	include vmwaretools

resources { 'firewall':
  purge => true,
}

#resources { 'firewallchain':
 # purge => true,
#}


Firewall {
  before  => Class['my_fw::post'],
  require => Class['my_fw::pre'],
}

class { ['my_fw::pre', 'my_fw::post']: }

}

