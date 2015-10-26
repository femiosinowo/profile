class profiles::wordpress {

  class { selinux: mode => 'enabled' }

  firewall { '100 allow Port 80':
    dport  => 80,
    proto  => tcp,
    action => accept,
  }


}
