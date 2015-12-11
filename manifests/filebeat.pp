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

      }
      ,
    }
    ,
  }

  file { '/etc/pki/tls/certs/logstash-forwarder.crt':
    ensure => file,
    source => "puppet:///modules/profile/logstash/logstash-forwarder.crt",
  # template('profile/logstash/logstash-forwarder.crt'),
  }

}

#
