class profile::jenkins_master () {
  include jenkins::master

  #class { selinux: mode => 'disabled' }

  firewall { '120 allow Jenkins on 8080':
    dport  => 8080,
    proto  => tcp,
    action => accept,
  }



}
