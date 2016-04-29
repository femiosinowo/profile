class profile::profile_jira () {
  # include jdk_oracle
  #class { 'java': distribution => 'jdk', }
include java
  java::oracle { 'jdk8':
    ensure  => 'present',
    version => '8',
    java_se => 'jdk',
  }

  class { 'postgresql::server':
  }

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