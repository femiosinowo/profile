class profile::prof_sensu () {
  
#   class { 'sensu':
#    rabbitmq_password => 'correct-horse-battery-staple',
#    server            => true,
#    api               => true,
#    plugins           => [
#      'puppet:///data/sensu/plugins/ntp.rb',
#      'puppet:///data/sensu/plugins/postfix.rb'
#    ]
#  }
#
#  sensu::handler { 'default':
#    command => 'mail -s \'sensu alert\' femi@paosin.local',
#  }
#
#  sensu::check { 'check_ntp':
#    command     => 'PATH=$PATH:/usr/lib/nagios/plugins check_ntp_time -H pool.ntp.org -w 30 -c 60',
#    handlers    => 'default',
#    subscribers => 'sensu-test'
#  }
  
  
  
  package { 'sensu-plugins-disk-checks':
  ensure   => '0.0.1',
  provider => sensu_gem,
}

  package { 'sensu-plugins-ntp':
  ensure   => 'latest',
  provider => sensu_gem,
}

  
  
    firewall { '101 allow 80,3306,443':
    dport  => [3000],
    proto  => tcp,
    action => accept,
  }
  
  
  
  }
