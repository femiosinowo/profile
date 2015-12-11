class profile::filebeat (
  $prospectors = {
    log_type => 'syslog',
    log_path => ['/var/log/*.log', '/var/log/syslog', '/var/log/auth.log'],
  }
) {
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
      'log_path' => {
        'hosts'       => ['elk-stack:5044'],
        'loadbalance' => true,
        # 'tls'
      }
      ,
    }
    ,
  }

}

#
