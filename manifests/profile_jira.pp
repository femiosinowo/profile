class profile::profile_jira () {
  include jdk_oracle

  class { 'jira': javahome => '/opt/java', }

  firewall { '120 allow puppet stuff':
    dport  => [8080],
    proto  => tcp,
    action => accept,
  }
}