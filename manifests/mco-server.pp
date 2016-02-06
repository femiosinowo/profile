class profile::mco-server () {
  class { '::mcollective':
    hosts           => ['activemq.paosin.local'],
    client_password => 'P@ssw0rdP@ssw0rd ',
    server_password => 'P@ssw0rdP@ssw0rd',
    psk_key         => 'f525ae7c92fca724b06ed6701cf99ca255e992f9a057084ddbfb75c73dc9c4d9',
  }
  # Every node installs the server
  include mcollective::server
}