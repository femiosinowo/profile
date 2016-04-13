class profile::sensu_client(){

  class { 'sensu':
    rabbitmq_password => 'sensu',
    rabbitmq_host => 'sensu.paosin.local',
    subscriptions => 'sensu-test',
    rabbitmq_ssl_private_key => "puppet:///modules/profile/ssl_certs/client/key.pem",
    rabbitmq_ssl_cert_chain  => "puppet:///modules/profile/ssl_certs/client/cert.pem",
  }
}
