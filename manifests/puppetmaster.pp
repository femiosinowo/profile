class profile::puppetmaster ($brokerHost = hiera('mcollective::brokerhost')) {
  # class { selinux: mode => 'disabled' }

  file { '/var/www/html/install.sh':
    ensure => file,
    source => "puppet:///modules/profile/puppet/install.sh",
    mode   => 'u+x'
  }

  firewall { '120 allow puppet stuff':
    dport  => [80, 443, 61613, 8140, 8088],
    proto  => tcp,
    action => accept,
  }

  package { 'puppet-lint':
    ensure   => '1.1.0',
    provider => 'gem',
  }

  Package {
    allow_virtual => false }

  include profile::activemq 
 
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