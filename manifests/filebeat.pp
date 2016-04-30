class profile::filebeat ($elkstack_host = hiera('elk::host'),) {
  class { '::filebeat':
    outputs     => {
      'logstash' => {
        'hosts'       => ["${elkstack_host}:5044"],
        'loadbalance' => true,
        # 'tls'
      }
      ,
    }
    ,
    prospectors => {
      'logstash' => {
        'paths'    => ['/var/log/*.log', '/var/log/cron', '/var/log/secure'],
        'log_type' => 'syslog',

      }
      ,
    }
    ,
  }

  #  file { '/etc/pki/tls/certs/logstash-forwarder.crt':
  #    ensure => file,
  #    source => "puppet:///modules/profile/logstash/logstash-forwarder.crt",
  #  }
}

#
