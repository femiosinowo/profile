class profile::sensu_server ($sensu_server_ip = hiera('sensu::server_ip'), $sensu::redis_host = '127.0.0.1') {
  $uchiwa_api_config = [{
      install_repo => false,
      name         => 'Site-1',
      host         => $sensu_server_ip,
      ssl          => false,
      insecure     => false,
      port         => 4567,
      path         => '',
      timeout      => 10
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
    ssl        => false,
  } ->
  rabbitmq_vhost { '/sensu': } ->
  rabbitmq_user { 'sensu': password => 'sensu' } ->
  rabbitmq_user_permissions { 'sensu@/sensu':
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
  } ->
  class { 'redis': listen => '127.0.0.1' } ->
#  class { 'sensu':
#    server            => true,
#    api               => true,
#    rabbitmq_user     => 'sensu',
#    rabbitmq_password => 'sensu',
#    rabbitmq_vhost    => '/sensu',
#    #    rabbitmq_ssl_private_key => "puppet:///modules/profile/ssl_certs/client/key.pem",
#    #    rabbitmq_ssl_cert_chain  => "puppet:///modules/profile/ssl_certs/client/cert.pem",
#    rabbitmq_host     => 'localhost',
#    redis_host        => '127.0.0.1',
#    api_host          => $sensu_server_ip,
#    api_user          => 'sensu',
#    api_password      => 'sensu',
#    api_port          => 4567,
#  } ->
  class { 'uchiwa':
    install_repo        => false,
    sensu_api_endpoints => $uchiwa_api_config,
  } ->
  firewall { '101 allow 3000, 4567, 5672,8080,15671,15672':
    dport  => [3000, 4567, 5672, 8080, 15671, 15672, 4242],
    proto  => tcp,
    action => accept,
  }

}
