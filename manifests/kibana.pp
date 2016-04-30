class profile::kibana () {
  # class { '::kibana': }
  cron { 'restart-kibana':
    command => 'service kibana4 restart',
    user    => 'root',
    hour    => 0,
    minute  => 30,
  }

  package { 'wget': ensure => latest }

  class { '::kibana4':
    # package_ensure   => '4.3.0-linux-x64',
    require          => Package['wget'],
    package_provider => 'archive',
    service_ensure   => true,
    service_enable   => true,
    symlink          => true,
    manage_user      => true,
    kibana4_user     => kibana4,
    kibana4_group    => kibana4,
    kibana4_gid      => 200,
    kibana4_uid      => 200,
    config           => {
      'server.port'       => 5601,
      'server.host'       => '0.0.0.0',
      'elasticsearch.url' => 'http://localhost:9200',
    }
  }

  firewall { '102 Allow ELKStacks':
    dport  => [9200, 5044, 5601],
    proto  => tcp,
    action => accept,
  }

}