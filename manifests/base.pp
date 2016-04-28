class profile::base ($brokerHost = hiera('mcollective::brokerhost')) {
  include ssh
  include motd
  include stdlib
  include resolver
  include epel

  # include selinux
  # include vmwaretools

  # common packages needed everywhere
  package { ['tree', 'sudo', 'screen', 'man']: ensure => present, }

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

  file { "/etc/mcollective/facts.yaml":
    owner    => root,
    group    => root,
    mode     => 400,
    loglevel => debug, # reduce noise in Puppet reports
    content  => inline_template("<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime_seconds|timestamp|free)/ }.to_yaml %>"),
  # exclude
  # rapidly
  # changing
  # facts
  }

  file { "/etc/facter/facts.d/": ensure => directory }

  include mcollective::server

  mcollective::plugin::agent { 'filemgr': }

  mcollective::plugin::agent { 'nettest': }

  mcollective::plugin::agent { 'package': }

  mcollective::plugin::agent { 'service': }

  mcollective::plugin::agent { 'puppet': }

}

