class profile::kibana () {
  # class { '::kibana': }

  class { '::kibana4':
    package_ensure   => '4.3.0-linux-x64',
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

}