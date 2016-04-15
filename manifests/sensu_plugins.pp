class profile::sensu_plugins () {
  file { '/opt/sensu-plugins': ensure => directory, }

  staging::deploy { 'sensu-community-plugins.tar.gz':
    source  => 'https://github.com/sensu/sensu-community-plugins/archive/master.tar.gz',
    target  => '/opt/sensu-plugins',
    require => File['/opt/sensu-plugins'],
  }

  sensu::handler { 'default': command => 'mail -s \'sensu alert\' femi@paosin.local', }

  sensu::check { 'check_cron':
    command     => '/opt/sensu-plugins/sensu-community-plugins-master/plugins/processes/check-procs.rb -p crond -C   1',
    handlers    => 'default',
    subscribers => 'base',
    require     => Staging::Deploy['sensu-community-plugins.tar.gz'],
  }
  
  sensu::check { 'check_disk':
    command => '/opt/sensu-plugins/sensu-community-plugins-master/plugins/system/check-disk.rb',
    handlers => 'default',
    subscribers => 'base',
    require => Staging::Deploy['sensu-community-plugins.tar.gz'],
  }

}
