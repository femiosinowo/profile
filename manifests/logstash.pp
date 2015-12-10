class profile::logstash () {
  file { '/etc/pki/tls':
    ensure => directory,
    group  => root,
    alias  => 'cert_dir'
  }

  class { 'logstash':
    require      => File['cert_dir'],
    ensure       => present,
    java_install => true,
    require      => Exec['create_certs']
  }

  exec { 'create_certs':
    path    => 'C:/Windows/System32/WindowsPowerShell/v1.0',
    command => 'openssl req -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout /etc/pki/tls/private/logstash-forwarder.key -out /etc/pki/tls/certs/logstash-forwarder.crt',
  }

  logstash::configfile { '/etc/logstash/conf.d/config.conf': content => template('profile/logstash/config.conf.erb'), }

}