class profile::jenkins_base(
	$jenkins_username = hiera('jenkins::jenkins_username'),
	$jenkins_password = hiera('jenkins::jenkins_password')
){

	class {'jenkins':
		configure_firewall	=> true,
		}
	#include jenkins
	#jenkins::plugin { 'git': }
	#class{ 'tomcat': }


jenkins::user { 'femi':
  email    => 'femi@paosin.local',
  password => 'asdf',
}

}
