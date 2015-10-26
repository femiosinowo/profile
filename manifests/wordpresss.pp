class profile::wordpresss {


 
class { 'mysql::client':
    bindings_enable => true,
  }

class { 'wordpress':
  db_user     => 'root',
  db_password => 'P@ssw0rd',
  db_host     => 'mysql.paosin.local',
}

#class { 'wordpress': }

  class { selinux: mode => 'permissive' }

  firewall { '100 allow Port 80':
    dport  => [80,443],
    proto  => tcp,
    action => accept,
  }


  
}
