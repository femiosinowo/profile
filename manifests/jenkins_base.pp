class profile::jenkins_base(
	$jenkins_username = hiera('jenkins::jenkins_username'),
	$jenkins_password = hiera('jenkins::jenkins_password')
){

	class { 'firewall': }
	class {'jenkins':
		configure_firewall	=> false,
		}
	#include jenkins
	#jenkins::plugin { 'git': }
	#class{ 'tomcat': }

}
