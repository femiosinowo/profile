class profile::nexus () {
  class { '::java': }

  class { '::nexus':
    version    => '2.8.0',
    revision   => '05',
    nexus_root => '/srv', # All directories and files will be relative to this
  }

  Class['::java'] ->
  Class['::nexus']
  
    firewall { '120 allow puppet stuff':
    dport  => [8081],
    proto  => tcp,
    action => accept,
  }
}