class profile::base ($brokerHost = hiera('mcollective::brokerhost')) {
  include ssh
  include motd
  include stdlib
  include resolver
  include epel
  include wget

  # include selinux
  # include vmwaretools
  file { "/etc/cron.d/puppet":
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => 0644,
    content => inline_template("15 * * * * root /usr/bin/puppet agent --onetime --no-daemonize --no-splay\n"
    ),
  # content => inline_template("<%= scope.function_fqdn_rand([60]) %> * * * * root /usr/bin/puppet agent --onetime --no-daemonize
  # --no-splay\n"),
  }

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

 
  #include mcollective::server
  include profiles::filebeat
  mcollective::plugin::agent { 'filemgr': }

  mcollective::plugin::agent { 'nettest': }

  mcollective::plugin::agent { 'package': }

  mcollective::plugin::agent { 'service': }

  mcollective::plugin::agent { 'puppet': }

}

