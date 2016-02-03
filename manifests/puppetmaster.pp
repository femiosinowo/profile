class profile::puppetmaster ($brokerHost = hiera('mcollective::brokerhost')) {
  # class { selinux: mode => 'disabled' }

  file { '/var/www/html/install.sh':
    ensure => file,
    source => "puppet:///modules/profile/puppet/install.sh",
    mode   => 'u+x'
  }

  firewall { '120 allow puppet stuff':
    dport  => [80, 443, 61613,61614, 8140, 8088],
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
  
#  class { '::mcollective':
#    broker_host       => $brokerHost,
#    broker_port       => '61614',
#    security_provider => 'psk',
#    security_secret   => 'P@ssw0rd',
#    use_node          => false,
#  }
#  include ::mcollective::client
  
  class { 'mcollective':
  stomp_host     =>$brokerHost,
  stomp_user     => 'mcollective',
  stomp_password => 'P@ssw0rd',
  client         => true,
  client_group   => 'mco-users',
}


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