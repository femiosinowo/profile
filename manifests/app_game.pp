class profile::app_game(){
	
	class { '::tomcat'
  source        => 'apache-tomcat-7.0.39.tar.gz',
  deploymentdir => '/home/example.com/apps/apache-tomcat',
  user          => 'example.com',
  group         => 'mygroup',
  default_webapp_docs        => 'present',
  default_webapp_examples    => 'present',
  default_webapp_hostmanager => 'present',
  default_webapp_manager     => 'present',
  default_webapp_root        => 'present'
}

}