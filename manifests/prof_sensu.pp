class profile::prof_sensu () {
  class { 'sensu':
    rabbitmq_password => 'correct-horse-battery-staple',
    server            => true,
    api               => true,
    plugins           => ['puppet:///data/sensu/plugins/ntp.rb', 'puppet:///data/sensu/plugins/postfix.rb']
  }

  Package {
    require => Class['sensu'], }

  sensu::handler { 'default':
    command => 'mail -s \'sensu alert\' femi@paosin.local',
    require => Class['sensu']
  }

  package { 'sensu-plugins-disk-checks':
    ensure   => '0.0.1',
    provider => sensu_gem,
  }

  package { 'sensu-plugins-ntp':
    ensure   => 'latest',
    provider => sensu_gem,
  }

  firewall { '101 allow 80,3306,443':
    dport  => [3000, 4567],
    proto  => tcp,
    action => accept,
  }

}
