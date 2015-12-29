class profile::network_p () {
  network::if::static { 'eth0':
    ensure    => 'up',
    ipaddress => hiera('network::ipaddress'),
    netmask   => hiera('network::netmask'),
  }

  class { 'network::global':
    gateway => hiera('network::gateway_addr'),
  }
}