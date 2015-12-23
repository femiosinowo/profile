class profile::base {
  include ssh
  include motd
  include stdlib
  include resolver
  include epel
  # include selinux
  # include vmwaretools
  # ntp module
  # class { '::ntp':
  #  servers => [ '0.us.pool.ntp.org', '1.us.pool.ntp.org' ],
  #}


  # base firewall config
  #include profile::firewall

  # common packages needed everywhere
  package { ['tree', 'sudo', 'screen']: ensure => present, }

  # file beat for log shipping
  #include profile::filebeat
  
  class { '::ntp':
    servers => [ '0.pool.ntp.org', '2.centos.pool.ntp.org', '1.rhel.pool.ntp.org'],
  }
  

}

