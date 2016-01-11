class profile::jenkins_slave(
		$jenkins_ui_user = hiera('jenkins::jenkins_ui_user'),
		$jenkins_ui_pass = hiera('jenkins::jenkins_ui_pass')
){
	class { 'jenkins::slave':
   		 masterurl => 'http://jenkins-master1.paosin.local:8080',
   		 ui_user => $jenkins_ui_user,
   		 ui_pass => $jenkins_ui_pass,
  }
  
  class { selinux: mode => 'disabled' }

  firewall { '110 allow Jenkins on 8080':
    dport  => 8080,
    proto  => tcp,
    action => accept,
  }

}
