class profile::network () {
  network::if::static { 'eth0':
    ensure    => 'up',
    ipaddress => hiera('network::ipaddress'),
  }

  class { 'network::global':
    gateway => hiera('network::gateway_addr'),
    netmask => hiera('network::netmask'),
  }

}