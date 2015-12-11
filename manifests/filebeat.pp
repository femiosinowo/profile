class profile::filebeat ($log_path = ['/var/log/*.log', '/var/log/syslog', '/var/log/auth.log'], $log_type = 'syslog',) {
  class { '::filebeat':
    outputs => {
      'logstash' => {
        'hosts'       => ['elk-stack:5044'],
        'loadbalance' => true,
        # 'tls'
      }
      ,
    }
    ,
  }

}