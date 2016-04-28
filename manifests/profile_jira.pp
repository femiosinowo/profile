class profile::profile_jira () {
  class { 'jira': javahome => '/opt/java', }

}