class profile::wordpress {


class { '::wordpress':
  db_user     => 'femi',
  db_password => 'P@ssw0rd',
  db_host     => 'mysql.paosin.local',
}


  class { selinux: mode => 'permissive' }

  firewall { '100 allow Port 80':
    dport  => [80,443],
    proto  => tcp,
    action => accept,
  }


 
}
