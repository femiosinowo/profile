class profile::network($network::ipaddress){
  
    network::if::static { 'eth0':
    ensure    => 'up',
    ipaddress => $network::ipaddress,
  }
  
}