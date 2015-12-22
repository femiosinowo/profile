class profile::firewall (
  $firewall_desc   = hiera('firewall::desc'),
  $firewall_ports  = hiera('firewall::ports'),
  $firewall_proto  = hiera('firewall::proto'),
  $firewall_action = hiera('firewall::action'),) {
  resources { 'firewall': purge => true, }

  Firewall {
    before  => Class['my_fw::post'],
    require => Class['my_fw::pre'],
  }

  class { ['my_fw::pre', 'my_fw::post']:
  }

  firewall { '100 Allow':
    dport  => $firewall_ports,
    proto  => $firewall_proto,
    action => $firewall_action,
  }

}