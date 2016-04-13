class profile::sensu_client () {
  class { 'sensu':
    server            => false,
    api               => true,
    rabbitmq_user     => 'sensu',
    rabbitmq_password => 'sensu',
    rabbitmq_host     => '10.0.0.58',
    subscriptions     => 'sensu-test',
    rabbitmq_ssl_private_key => "puppet:///modules/profile/ssl_certs/client/key.pem",
    rabbitmq_ssl_cert_chain  => "puppet:///modules/profile/ssl_certs/client/cert.pem",
    redis_host        => '10.0.0.58',
  }
}
