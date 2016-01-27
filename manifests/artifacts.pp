class profile::artifacts () {
  class { 'artifactory': serverAlias => ['artifactory', 'artifactory.paosin.local'] }

}