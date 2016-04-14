class profile::sensu_client () {
  class { 'sensu':
    server     => false,
    api        => false,
    rabbitmq_user            => 'sensu',
    rabbitmq_password        => 'sensu',
    rabbitmq_vhost           => '/sensu',
    subscriptions            => 'base',
    rabbitmq_ssl_private_key => "puppet:///modules/profile/ssl_certs/client/key.pem",
    rabbitmq_ssl_cert_chain  => "puppet:///modules/profile/ssl_certs/client/cert.pem",

    redis_password           => 'sensu',
    redis_host               => $sensu_server_ip,
    api_host                 => $sensu_server_ip,
    rabbitmq_host            => $sensu_server_ip,
  }
}
