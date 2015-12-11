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
      'logstash' => {
        'paths'    => ['/var/log/*.log', '/var/log/syslog', '/var/log/auth.log'],
        'log_type' => 'syslog',
        # 'tls'
      }
      ,
    }
    ,
  }

}

#
