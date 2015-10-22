class profile::jenkins_master () {
  include jenkins::master

  class { selinux: mode => 'enforcing' }

  firewall { '100 allow Jenkins on 8080':
    dport  => 8080,
    proto  => tcp,
    action => accept,
  }



}
