class profile::weblogic(){
 #
 #exec { 'wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" "https://edelivery.oracle.com/otn-pub/java/jdk/7u25-b15/jdk-7u25-linux-x64.tar.gz"':
  #cwd     => "/etc/puppet/environments/production/modules/profile/files/",
  #creates => "/var/tmp/myfile",
  #path    => ["/usr/bin", "/usr/sbin"]
#}
 #jdk
 include jdk7
 jdk7::install7{ 'jdk1.7.0_25':
  version               => "7u25" ,
  full_version          => "jdk1.7.0_25",
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
