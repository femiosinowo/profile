class profile::jira () {
  class { '::jira': javahome => '/opt/java', }

}