class profile::wordpresss {
  # # Configure apache
  include apache
  include apache::mod::php
  include apache::mod::ssl

  # # Configure mysql
  include '::mysql::server'

  class { '::mysql::client': bindings_enable => true, }

  # #Install wordpress

  class { 'wordpress':
    db_user     => 'femi',
    db_password => 'P@ssw0rd',
    db_host     => 'mysql.paosin.local',
  }

  # class { 'wordpress': }

  class { selinux:
    mode => 'permissive'
  }

  firewall { '100 allow Port 80':
    dport  => [80, 443],
    proto  => tcp,
    action => accept,
  }

}
