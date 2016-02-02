class profile::puppetmaster {
  # class { selinux: mode => 'disabled' }

 # class { 'apache':
  #}

  file { '/var/www/html/install.sh':
    ensure => file,
    source => "puppet:///modules/profile/puppet/install.sh",
    mode   => 'u+x'
  }

  firewall { '120 allow puppet stuff':
    dport  => [80,443, 61613, 8140, 8088],
    proto  => tcp,
    action => accept,
  }

  package { 'puppet-lint':
    ensure   => '1.1.0',
    provider => 'gem',
  }

  Package {
    allow_virtual => false }

class { '::mcollective':
  broker_host       => $::fqdn,
  broker_port       => '61614',
  security_provider => 'psk',
  security_secret   => 'P@S5w0rD',
  use_node          => false,
}
include ::mcollective::node

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