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
      input_type => 'syslog',
      # paths => ['/var/log/*.log', '/var/log/syslog', '/var/log/auth.log'],
    }
    ,
  }

}

#
