class profile::sensu_plugins () {
  Exec {
    path => '/usr/bin:/opt/sensu/embedded/bin/', }

  sensu::handler { 'default': command => 'mail -s \'sensu alert\' femi@paosin.local', }

  package { 'sensu-plugins-cpu-checks':
    ensure   => 'installed',
    provider => sensu_gem,
  }

  package { 'sensu-plugins-ntp':
    ensure   => 'installed',
    provider => sensu_gem,
  }

  package { 'sensu-plugins-disk-checks':
    ensure   => 'installed',
    provider => sensu_gem,
  }

  package { 'sensu-plugins-memory-checks':
    ensure   => 'installed',
    provider => sensu_gem,
  }

  sensu::check { 'check_disk':
    command     => 'check-disk-usage.rb -w 80 -c 90',
    handlers    => 'default',
    subscribers => 'base',
    require     => Package['sensu-plugins-cpu-checks'],
  }
  sensu::check { 'check_memory':
    command     => 'check-memory-percent.rb',
    handlers    => 'default',
    subscribers => 'base',
    require     => Package['sensu-plugins-memory-checks'],
  }
  #  package { 'centos-release-SCL':
  #    ensure   => latest,
  #    provider => yum,
  #  }
  #
  #  package { 'ruby193':
  #    ensure   => latest,
  #    provider => yum,
  #    require  => Package['centos-release-SCL']
  #  }
  #
  #  # profiled::script { 'ruby193.sh': content => 'source /opt/rh/ruby193/enable' }
  #
  #  file { '/opt/sensu-plugins': ensure => directory, }
}
