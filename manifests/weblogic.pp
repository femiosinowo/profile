class profile::weblogic(){
 #
 #exec { 'cp  -rp /root/software/jdk-7u25-linux-x64.tar.gz .':
 # cwd     => "/etc/puppet/environments/production/modules/profile/files/",
  #creates => "/var/tmp/myfile",
  #path    => ["/usr/bin", "/usr/sbin"]
#}
 #jdk
 include jdk7
 jdk7::install7{ 'jdk1.8.0_73':
  version               => "8u73" ,
  full_version          => "jdk1.8.0_73",
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
