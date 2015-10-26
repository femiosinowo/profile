class profile::wordpress {


 
class { 'wordpress': }

  class { selinux: mode => 'permissive' }

  firewall { '100 allow Port 80':
    dport  => [80,443],
    proto  => tcp,
    action => accept,
  }


 
}
