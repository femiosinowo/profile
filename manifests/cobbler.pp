class profile::cobbler(){
  
    firewall { '200 tftp for cobbler':
    dport  => 69,
    proto  => udp,
    action => accept,
  }
  
  
   firewall { '210 allow multiple ports to be opened':
    dport  => [22,69,80,443,25150,25151],
    proto  => tcp,
    action => accept,
  }

 class { 'python' :
  version    => 'system',
  pip        => 'present',
  dev        => 'present',
  virtualenv => 'present', 
}
  
  
  $cobbler_settings = {
    'server'        => '10.0.0.20',
    'next_server'   => '10.0.0.20',
    'pxe_just_once' => 1
}

#class {'::cobbler':
 # cobbler_config => $cobbler_settings,
#}
  
  
  
}