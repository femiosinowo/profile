class profile::network($network::ipaddress,$network::gateway_addr ,  $network::netmask){
  
    network::if::static { 'eth0':
    ensure    => 'up',
    ipaddress => $network::ipaddress,
  }
  
  
    class { 'network::global':
    gateway => $network::gateway_addr,
    netmask   => $network::netmask,
  }
  
  
}