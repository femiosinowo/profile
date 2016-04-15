class profile::sensu_plugins () {
  
    package { 'centos-release-SCL':
    ensure   => latest,
    provider => yum,
  }
  
  class { 'ruby':
  version         => '1.9.3',
  gems_version    => '1.8.24',
  rubygems_update => false
}

  file { '/opt/sensu-plugins': ensure => directory, }

  sensu::handler { 'default': command => 'mail -s \'sensu alert\' femi@paosin.local', }

  package { 'sensu-plugins-cpu-checks':
    ensure   => '0.0.1',
    provider => sensu_gem,
  }

  package { 'sensu-plugins-disk-checks':
    ensure   => '0.0.1',
    provider => sensu_gem,
  }

  sensu::check { 'check_disk':
    command     => 'check-disk-usage.rb -w 80 -c 90',
    handlers    => 'default',
    subscribers => 'base',
    require     => Package['sensu-plugins-cpu-checks'],
  }

}
