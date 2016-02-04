class profile::base ($brokerHost = hiera('mcollective::brokerhost') ) {
  include ssh
  include motd
  include stdlib
  include resolver
  include epel

  # include selinux
  include vmwaretools

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

