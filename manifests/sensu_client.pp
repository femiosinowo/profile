class profile::sensu_client ($sensu_server_ip = hiera('sensu::server_ip')) {



 

  #    class { 'sensu':
  #    server     => false,
  #    api        => true,
  #    rabbitmq_user            => 'sensu',
  #    rabbitmq_password        => 'sensu',
  #    rabbitmq_vhost           => '/sensu',
  #    subscriptions            => 'base',
  # #    rabbitmq_ssl_private_key => "puppet:///modules/profile/ssl_certs/client/key.pem",
  # #    rabbitmq_ssl_cert_chain  => "puppet:///modules/profile/ssl_certs/client/cert.pem",
  #
  #    redis_password           => 'sensu',
  #    redis_host               => $sensu_server_ip,
  #    api_host                 => $sensu_server_ip,
  #    rabbitmq_host            => $sensu_server_ip,
  #
  #    api_user          => 'sensu',
  #    api_password      => 'sensu',
  #    api_port          => 4567,
  #  }
}
