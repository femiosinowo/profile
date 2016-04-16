class profile::sensu_plugins () {
  Exec {
    path => '/usr/bin:/opt/sensu/embedded/bin/', }

  pathmunge { '/opt/sensu/embedded/bin/': }

  sensu::handler { 'default': command => 'mail -s \'sensu alert\' femi@paosin.local', }

  profile::plugchecksensu { 'cpu-checks':
    pluginname => 'sensu-plugins-cpu-checks',
    command    => 'check-cpu.rb'
  }

  profile::plugchecksensu { 'selinux':
    pluginname => 'sensu-plugins-selinux',
    command    => 'check-selinux.rb'
  }

  profile::plugchecksensu { 'ntp':
    pluginname => 'sensu-plugins-ntp',
    command    => 'check-ntp.rb'
  }

  profile::plugchecksensu { 'disk-check':
    pluginname => 'sensu-plugins-disk-checks',
    command    => 'check-disk-usage.rb -w 80 -c 90'
  }

  profile::plugchecksensu { 'memory':
    pluginname => 'sensu-plugins-memory-checks',
    command    => 'check-memory-percent.rb'
  }

#  profile::plugchecksensu { 'logstash':
#    pluginname => 'sensu-plugins-logstash',
#    command    => 'handler-logstash'
#  }

#  profile::plugchecksensu { 'fs-check':
#    pluginname => ' sensu-plugins-filesystem-checks',
#    command    => 'check-dir-count.rb'
#  }

  #  sensu::check { 'check_disk':
  #    command     => 'check-disk-usage.rb -w 80 -c 90',
  #    handlers    => 'default',
  #    subscribers => 'base',
  #    require     => Package['sensu-plugins-cpu-checks'],
  #  }
  #
  #  sensu::check { 'check_memory':
  #    command     => 'check-memory-percent.rb',
  #    handlers    => 'default',
  #    subscribers => 'base',
  #    require     => Package['sensu-plugins-memory-checks'],
  #  }
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
