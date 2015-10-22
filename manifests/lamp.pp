class profile::lamp(
	$lamp_password	= hiera('lamp::lamp_password'),
	$lamp_home	= hiera('lamp::lamp_home'),
	$lamp_group	= hiera('lamp::lamp_group'),
	$mysql_password	= hiera('lamp::mysql_password')
	) {

	#class{'apache':} 
	#class{'php': }
	include apache
	include apache::mod::php
#	motd::register{ 'Apache': }
#class apache {
 # include apache::install, apache::config, apache::service

 # motd::register{ 'Apache': }
#}
	#include php
#	class { 'phpmyadmin': }

	class { '::mysql::server':
  		root_password           => $mysql_password,
  		remove_default_accounts => true,
  		#override_options        => $override_options
	}
	user{'lamp':
		ensure		=> present,
		password	=> $lamp_password,
		home		=> $lamp_home,
	#	gid		=> $lamp_group,
	}

}
