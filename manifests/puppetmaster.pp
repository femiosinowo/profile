class profile::puppetmaster {
  #class { selinux: mode => 'disabled' }

  firewall { '120 allow puppet stuff':
    dport  => [443, 61613, 8140, 8088],
    proto  => tcp,
    action => accept,
  }

  package { 'puppet-lint':
    ensure   => '1.1.0',
    provider => 'gem',
  }

  Package {
    allow_virtual => false }
    
#    class { 'hiera':
#  hierarchy => [
#    '%{environment}',
#    '%{clientcert}',
#    '%{osfamily}',
#    'defaults',
#    'common',
#    'global',
#  ],
#}

}