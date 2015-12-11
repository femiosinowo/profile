class profile::filebeat () {
  class { '::filebeat':
    outputs     => {
      'logstash' => {
        'hosts'       => ['elk-stack:5044'],
        'loadbalance' => true,
        # 'tls'
      }
      ,
    }
    ,
    prospectors => {
      log_type => 'syslog',
      log_path => ['/var/log/*.log', '/var/log/syslog', '/var/log/auth.log'],
    }
    ,
  }

}

#
