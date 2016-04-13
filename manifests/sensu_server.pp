class profile::sensu_server () {
  $uchiwa_api_config = [
    #    {
    #      host  => '10.56.5.8',
    #    },
    {
      install_repo => false,
      name         => 'sensu.paosin.local',
      host         => '10.0.0.57',
      ssl          => false,
      insecure     => false,
      port         => 4567,
      user         => 'sensu',
      pass         => 'sensu',
      path         => '',
      timeout      => 5
    }
    ]

  file { '/etc/rabbitmq/ssl/cacert.pem': source => 'puppet:///modules/profile/ssl_certs/sensu_ca/cacert.pem', }

  file { '/etc/rabbitmq/ssl/cert.pem': source => 'puppet:///modules/profile/ssl_certs/server/cert.pem', }

  file { '/etc/rabbitmq/ssl/key.pem': source => 'puppet:///modules/profile/ssl_certs/server/key.pem', }
  class { 'erlang': epel_enable => true } ->
  class { 'rabbitmq':
    ssl_key    => '/etc/rabbitmq/ssl//key.pem',
    ssl_cert   => '/etc/rabbitmq/ssl//cert.pem',
    ssl_cacert => '/etc/rabbitmq/ssl//cacert.pem',
    ssl        => true,
  } ->
  rabbitmq_vhost { '/sensu': } ->
  rabbitmq_user { 'sensu': password => 'password' } ->
  rabbitmq_user_permissions { 'sensu@/sensu':
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
  } ->
  class { 'redis': listen => '127.0.0.1' } ->
  class { 'sensu':
    server => true,
    api    => true,
    rabbitmq_password        => 'password',
    rabbitmq_ssl_private_key => "puppet:///modules/profile/ssl_certs/client/key.pem",
    rabbitmq_ssl_cert_chain  => "puppet:///modules/profile/ssl_certs/client/cert.pem",
    rabbitmq_host            => 'sensu.paosin.local',
    subscriptions            => 'sensu-test',
  } ->
  class { 'uchiwa':
    install_repo        => false,
    sensu_api_endpoints => $uchiwa_api_config,
  }

  firewall { '101 allow 3000, 4567, 5672,8080,15671,15672':
    dport  => [3000, 4567, 5672, 8080, 15671, 15672],
    proto  => tcp,
    action => accept,
  }

}
