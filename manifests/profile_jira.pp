class profile::profile_jira () {
  # include jdk_oracle
class { 'oracle_java':
  version => '8u45',
  type    => 'jdk'
}

  class { 'postgresql::server': }

  postgresql::server::db { 'jira':
    user     => 'jiraadm',
    password => postgresql_password('jiraadm', 'mypassword'),
  }

  class { 'jira':
    javahome => '/usr',
    db       => 'postgresql',
    dbuser   => 'jiraadm',
  }

  class { 'jira::facts':
  }



  firewall { '120 allow puppet stuff':
    dport  => [8080],
    proto  => tcp,
    action => accept,
  }
}