class profile::profile_jira () {
  include jdk_oracle
  class { 'jira': javahome => '/opt/java', }

}