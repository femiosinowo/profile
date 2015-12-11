class profile::filebeat () {
  class { '::filebeat':
    outputs  => {
      'logstash' => {
        'hosts'       => ['elk-stack:5044'],
        'loadbalance' => true,
        # 'tls'
      }
      ,
    }
    ,
    filebeat => {
      'prospectors' => {
        'paths'         => ['/var/log/*.log', '/var/log/syslog', '/var/log/auth.log'],
        'document_type' => 'syslog',
        'input_type'    => 'log',
      }
      ,
    }
    ,
  }

}