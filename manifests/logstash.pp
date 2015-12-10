class profile::logstash(){
  
  class { 'logstash':
    ensure        => present,
    java_install  => true,
    exec{'mkdir -p /etc/pki/tls'}
    exec{'openssl req -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout /etc/pki/tls/private/logstash-forwarder.key -out /etc/pki/tls/certs/logstash-forwarder.crt'}
  }
  

 logstash::configfile { '/etc/logstash/conf.d/config.conf':
  content => template('profile/logstash/config.conf.erb')
}

}