class profile::firewall{
  
  
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