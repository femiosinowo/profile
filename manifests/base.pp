class profile::base ($brokerHost = hiera('mcollective::brokerhost') ) {
  include ssh
  include motd
  include stdlib
  include resolver
  include epel

  # include selinux
  include vmwaretools

  # ntp module
  # class { '::ntp':
  #  servers => [ '0.us.pool.ntp.org', '1.us.pool.ntp.org' ],
  #}
 
#class { '::mcollective':
#  broker_host       =>  $brokerHost,
#  broker_port       => '61614',
#  security_provider => 'psk',
#  security_secret   => 'P@ssw0rd',
#  use_node          => false,
#}
#include ::mcollective::node

 
  # base firewall config
  # include profile::firewall

  # common packages needed everywhere
  package { ['tree', 'sudo', 'screen','man']: ensure => present, }

  # file beat for log shipping
  # include profile::filebeat

  class { '::ntp':
    servers => ['0.pool.ntp.org', '2.centos.pool.ntp.org', '1.rhel.pool.ntp.org'],
  }

  firewall { '100 ssh open':
    dport  => 22,
    proto  => tcp,
    action => accept,
  }

}

