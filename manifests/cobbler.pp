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

 
  
  
}