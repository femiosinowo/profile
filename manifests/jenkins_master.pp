class profile::jenkins_master () {
  # include jenkins::master
  package { 'wget': ensure => latest }

  class { 'jenkins::master': require => Package['wget'], }

  # class { selinux: mode => 'disabled' }

  firewall { '120 allow Jenkins on 8080':
    dport  => 8080,
    proto  => tcp,
    action => accept,
  }

}
