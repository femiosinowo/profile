class profile::artifacts () {
  # class { 'artifactory': serverAlias => ['artifactory', 'artifactory.paosin.local'] }
  # puppetlabs-java
  # NOTE: Nexus requires
  class { '::java':
  }

  class { '::nexus':
    version    => '2.8.0',
    revision   => '05',
    nexus_root => '/srv', # All directories and files will be relative to this
  }

  Class['::java'] ->
  Class['::nexus']
}