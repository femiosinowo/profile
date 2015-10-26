class profile::base {
  include ssh
  include motd
  include stdlib
  include resolver

  # include selinux
    include ::vmwaretools
#ntp module
class { '::ntp':
  servers => [ 'ntp1.corp.com', 'ntp2.corp.com' ],
}


  resources { 'firewall': purge => true, }

  Firewall {
    before  => Class['my_fw::post'],
    require => Class['my_fw::pre'],
  }

  class { ['my_fw::pre', 'my_fw::post']:
  }

  firewall { '100 Allow SSH':
    dport  => 22,
    proto  => tcp,
    action => accept,
  }

}

