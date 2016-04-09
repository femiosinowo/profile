class profile::weblogic(){
 #
 exec { 'cp /root/software/jdk-7u25-linux-x64.tar.gz /etc/puppet/environments/production/modules/profile/files/':
  #cwd     => "/etc/puppet/environments/production/modules/profile/files/",
  #creates => "/var/tmp/myfile",
  #path    => ["/usr/bin", "/usr/sbin"]
}
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
