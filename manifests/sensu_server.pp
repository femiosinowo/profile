class profile::sensu_server () {
  #include 'erlang'

  file { '/etc/rabbitmq/ssl/cacert.pem': source => 'puppet:///modules/profiles/puppet/ssl_certs/sensu_ca/cacert.pem', }

  file { '/etc/rabbitmq/ssl/cert.pem': source => 'puppet:///modules/profiles/puppet/ssl_certs/server/cert.pem', }

  file { '/etc/rabbitmq/ssl/key.pem': source => 'puppet:///modules/profiles/puppet/ssl_certs/server/key.pem', }
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
  class { 'redis': bind => '127.0.0.1'; } ->
  class { 'sensu':
    server                   => true,
    rabbitmq_password        => 'password',
    rabbitmq_ssl_private_key => "puppet:///modules/profiles/puppet/ssl_certs/client/key.pem",
    rabbitmq_ssl_cert_chain  => "puppet:///modules/profiles/puppet/ssl_certs/client/cert.pem",
    rabbitmq_host            => 'sensu.paosin.local',
    subscriptions            => 'sensu-test',
  }

  firewall { '101 allow 80,3306,443':
    dport  => [3000, 4567, 5672],
    proto  => tcp,
    action => accept,
  }

}
