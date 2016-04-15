class profile::sensu_plugins () {



  file { '/opt/sensu-plugins':
    ensure  => directory 
  }

  archive { 'sensu-plugins':
    ensure => present,
    url    => 'https://github.com/sensu/sensu-community-plugins/archive/master.tar.gz',
    target => '/opt/sensu-plugins',
    require => File['/opt/sensu-plugins']
  }

 
}
