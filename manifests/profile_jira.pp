class profile::profile_jira () {
  include jdk_oracle

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

  firewall { '120 allow puppet stuff':
    dport  => [8080],
    proto  => tcp,
    action => accept,
  }
}