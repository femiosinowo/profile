class profile::filebeat () {
  class { '::filebeat':
    outputs => {
      'logstash' => {
        'hosts'       => ['elk-stack:5044'],
        'loadbalance' => true,
      }
      ,
    }
    ,
  }

}