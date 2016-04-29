class profile::profile_jira () {
  # include jdk_oracle
  class { 'jdk_oracle': version => 8 , ensure => 'absent' }

  class { 'postgresql::server': }

  postgresql::server::db { 'jira':
    user     => 'jiraadm',
    password => postgresql_password('jiraadm', 'mypassword'),
  }

  class { 'jira':
    javahome => '/opt/java_home/',
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