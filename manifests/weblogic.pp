class profile::weblogic(){
 
 
 #jdk
 include jdk7
 jdk7::install7{ 'jdk1.7.0_40':
  version               => "7u40" ,
  full_version          => "jdk1.7.0_40",
  java_homes            => '/usr/java/',
  alternatives_priority => 18000,
  x64                   => true,
  download_dir          => "/install",
  urandom_java_fix      => false,
  source_path           => "puppet:///profile/jdk7/",
  default_links         => true,
  install_alternatives  => false,
}


#



}
