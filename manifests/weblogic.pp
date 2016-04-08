class profile::weblogic(){
 
 
 #jdk
 include jdk7
 jdk7::install7{ 'jdk1.7.0_79':
  version               => "7u79" ,
  full_version          => "jdk1.7.0_79",
  java_homes            => '/usr/java/',
  alternatives_priority => 18000,
  x64                   => true,
  download_dir          => "/install",
  urandom_java_fix      => false,
  source_path           => "puppet:///modules/profile/",
  default_links         => true,
  install_alternatives  => false,
}


#



}
