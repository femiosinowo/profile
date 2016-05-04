class profile::kibana () {
  # class { '::kibana': }


  file { "/etc/cron.d/kibana4":
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => 0644,
    content => inline_template("15 * * * * root service kibana4 restart\n"
    ),
  # content => inline_template("<%= scope.function_fqdn_rand([60]) %> * * * * root /usr/bin/puppet agent --onetime --no-daemonize
  # --no-splay\n"),
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

 

}