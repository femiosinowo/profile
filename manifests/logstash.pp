class profile::logstash () {
  file { '/etc/pki/tls/certs/logstash-forwarder.crt':
    ensure  => file,
    source  => "puppet:///modules/profile/logstash/logstash-forwarder.crt",
    alias   => 'cert_file',
    require => File['cert_dir'],
  }

  file { '/etc/pki/tls/certs':
    ensure => directory,
    group  => root,
    alias  => 'cert_dir',
    before => File['cert_file'],
  }

  class { '::logstash':
    ensure       => 'present',
    java_install => true,
    package_url  => 'https://download.elastic.co/logstash/logstash/packages/centos/logstash-2.1.1-1.noarch.rpm',
    require      => File['cert_dir'],
  # before       => Exec['create_certs'],
  #     manage_repo  => true,
  #    repo_version => 'latest',
  }

  logstash::configfile { '/etc/logstash/conf.d/config.conf': content => template('profile/logstash/config.conf.erb'), }

  firewall { '100 allow Jenkins on 8080':
    dport  => [80, 5601, 5044, 443, 9200],
    proto  => tcp,
    action => accept,
  }

  include profile::nginx

  # nginx::resource::upstream { 'kibana80': members => ['localhost:5601',] }
  nginx::resource::vhost { 'elkstack.paosin.local': proxy => 'http://localhost:5601', }
  #  exec { 'create_certs':
  #    require => File['cert_dir'],
  #    path    => "/usr/bin:/usr/sbin:/bin",
  #    command => 'openssl req -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout /etc/pki/tls/private/logstash-forwarder.key
  #    -out /etc/pki/tls/certs/logstash-forwarder.crt',
  #  }
}
