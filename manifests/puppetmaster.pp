class profile::puppetmaster {
  class { selinux: mode => 'disabled' }

  firewall { '100 allow puppet stuff':
    dport  => [443, 61613, 8140],
    proto  => tcp,
    action => accept,
  }

}